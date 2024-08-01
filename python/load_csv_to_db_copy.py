import os
import psycopg2
from sqlalchemy import create_engine, text
import yaml
from datetime import datetime
import argparse

# Load credentials from a dbt profile YAML file
def get_db_credentials(yaml_file_path, profile_name, target_name):
    with open(yaml_file_path, 'r') as file:
        profiles = yaml.safe_load(file)
        profile = profiles[profile_name]['outputs'][target_name]
        user = profile['user']
        password = profile['pass']
        host = profile['host']
        db_name = profile['dbname']
    return user, password, host, db_name

# Create the database engine
def create_db_engine(user, password, host, db_name):
    connection_string = f"postgresql+psycopg2://{user}:{password}@{host}/{db_name}"
    return create_engine(connection_string)

# Create schema
def create_schema(engine, schema_name):
    with engine.connect() as conn:
        conn.execute(text(f"CREATE SCHEMA IF NOT EXISTS {schema_name};"))

# Execute DDL statements from file
def execute_ddl(engine, ddl_file_path):
    with engine.connect() as conn:
        try:
            with open(ddl_file_path, 'r') as ddl_file:
                ddl_statements = ddl_file.read()
                conn.execute(text(ddl_statements))
                conn.commit()  # Ensure the transaction is committed
        except Exception as e:
            print(f"An error occurred: {e}")

# Truncate table
def truncate_table(conn, schema, table_name):
    try:
        cursor = conn.cursor()
        cursor.execute(f"TRUNCATE TABLE {schema}.{table_name};")
        conn.commit()
        print(f"Table {schema}.{table_name} truncated successfully.")
    except Exception as e:
        conn.rollback()
        print(f"An error occurred while truncating {schema}.{table_name}: {e}")
    finally:
        cursor.close()

# Get the row count of a CSV file
def get_csv_row_count(csv_file_path, encoding='utf-8'):
    with open(csv_file_path, 'r', encoding=encoding) as f:
        row_count = sum(1 for row in f) - 1  # Subtract 1 for the header row
    return row_count

# Get the row count of a table in the database
def get_table_row_count(conn, schema, table_name):
    cursor = conn.cursor()
    cursor.execute(f"SELECT COUNT(*) FROM {schema}.{table_name};")
    row_count = cursor.fetchone()[0]
    cursor.close()
    return row_count

# Load CSV data into the database using COPY
def load_csv_to_db(user, password, host, db_name, csv_file_path, table_name, schema, encoding='utf-8'):
    conn_string = f"host={host} dbname={db_name} user={user} password={password}"
    conn = psycopg2.connect(conn_string)
    try:
        truncate_table(conn, schema, table_name)
        
        # Get the number of records to be inserted
        records_to_insert = get_csv_row_count(csv_file_path, encoding)
        print(f"Number of records to be inserted into {schema}.{table_name}: {records_to_insert}")
        
        cursor = conn.cursor()
        with open(csv_file_path, 'r', encoding=encoding) as f:
            start_time = datetime.now()
            print(f"Starting to load {table_name} at {start_time}")
            try:
                cursor.copy_expert(f"COPY {schema}.{table_name} FROM STDIN WITH CSV HEADER NULL AS ''", f)
                conn.commit()
                print(f"Data loaded successfully into {schema}.{table_name}.")
            except Exception as copy_expert_exception:
                print(f"An error occurred during COPY: {copy_expert_exception}")
                conn.rollback()
            finish_time = datetime.now()
            print(f"Finished loading {table_name} at {finish_time}")
            print(f"Duration: {finish_time - start_time}")
        
        # Get the number of records actually inserted
        records_inserted = get_table_row_count(conn, schema, table_name)
        print(f"Number of records inserted into {schema}.{table_name}: {records_inserted}")
    except Exception as e:
        conn.rollback()
        print(f"An error occurred while loading {csv_file_path} into {schema}.{table_name}: {e}")
    finally:
        cursor.close()
        conn.close()

def main(csv_load):
    script_dir = os.path.dirname(os.path.abspath(__file__))
    repo_dir = os.path.dirname(script_dir)
    yaml_file_path = os.path.join(repo_dir, 'profiles.yml')
    profile_name = 'sanofi'
    target_name = 'stage'  # other options dev
    schema = 'patients_data'
    ddl_file_path = os.path.join(script_dir, 'config', 'synthea_tables_ddl.sql')
    comments_file_path = os.path.join(script_dir, 'config', 'synthea_comments.sql')
    pk_file_path = os.path.join(script_dir, 'config', 'synthea_pk.sql')
    fk_file_path = os.path.join(script_dir, 'config', 'synthea_fk.sql')
    csv_dir = 'C:\\a\\data\\Synthea\\output\\csv\\2024_07_24T04_23_25Z'
    start_with = 'observations.csv'
    # start_with = 'allergies.csv'
    skip_files = ['claims_transactions.csv']
    # single_file = 'patients.csv'
    single_file = None
    if single_file is not None:
        csv_files = [os.path.join(csv_dir, single_file)]
    else:
        csv_files = [os.path.join(csv_dir, f) for f in os.listdir(csv_dir) 
                     if f.endswith('.csv') and f >= start_with and f not in skip_files]

    # Get database credentials
    user, password, host, db_name = get_db_credentials(yaml_file_path, profile_name, target_name)

    # Create database engine
    engine = create_db_engine(user, password, host, db_name)

    # Create new schema
    create_schema(engine, schema)

    # Execute DDL statements to create tables
    execute_ddl(engine, ddl_file_path)

    if csv_load:
        # Load each CSV file into the corresponding table
        for csv_file in csv_files:
            table_name = os.path.splitext(os.path.basename(csv_file))[0]  # Assume table name matches file name
            load_csv_to_db(user, password, host, db_name, csv_file, table_name, schema)

    # execute_ddl(engine, comments_file_path)
    # execute_ddl(engine, pk_file_path)
    # execute_ddl(engine, fk_file_path)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Load data into PostgreSQL database.")
    parser.add_argument('--no_csv_load', action='store_false', dest='csv_load', help="Skip loading CSV files into the database.")
    parser.set_defaults(csv_load=True)
    args = parser.parse_args()
    main(csv_load=args.csv_load)
