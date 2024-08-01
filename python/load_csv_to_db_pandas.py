import os
import pandas as pd
from sqlalchemy import create_engine, text
import yaml

# Load credentials from a dbt profile YAML file
def get_db_credentials(yaml_file_path, profile_name, target_name):
    with open(yaml_file_path, 'r') as file:
        profiles = yaml.safe_load(file)
        # print(profiles)
        profile = profiles[profile_name]['outputs'][target_name]
        user = profile['user']
        password = profile['pass']
        host = profile['host']
        db_name = profile['dbname']
    return user, password, host, db_name

# Create the database engine
def create_db_engine(user, password, host, db_name):
    connection_string = f"postgresql+psycopg2://{user}:{password}@{host}/{db_name}"
    print(connection_string)
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
                print("Executing DDL statements:")
                # print(ddl_statements)
                conn.execute(text(ddl_statements))
                conn.commit()  # Ensure the transaction is committed
        except Exception as e:
            print(f"An error occurred: {e}")


# Load CSV data into the database
def load_csv_to_db(engine, csv_file_path, table_name, schema):
    df = pd.read_csv(csv_file_path)
    df.to_sql(table_name, engine, schema=schema, if_exists='replace', index=False)

def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    yaml_file_path = os.path.expanduser('~/.dbt/profiles.yml')
    profile_name = 'sanofi'
    target_name = 'stage' # other options dev
    schema = 'patients_data'
    ddl_file_path = os.path.join(script_dir, 'config', 'synthea_tables_ddl.sql')
    csv_dir = os.path.abspath(os.path.join(script_dir, '..', 'seeds', 'synthea'))
    print(csv_dir)
    csv_files = [os.path.join(csv_dir, f) for f in os.listdir(csv_dir) if f.endswith('.csv')]
    print(csv_files)

    # Get database credentials
    user, password, host, db_name = get_db_credentials(yaml_file_path, profile_name, target_name)

    # Create database engine
    engine = create_db_engine(user, password, host, db_name)

    # Create new schema
    create_schema(engine, schema)

    # Execute DDL statements to create tables
    execute_ddl(engine, ddl_file_path)

    # Load each CSV file into the corresponding table
    for csv_file in csv_files:
        table_name = os.path.splitext(os.path.basename(csv_file))[0]  # Assume table name matches file name
        load_csv_to_db(engine, csv_file, table_name, schema)

if __name__ == "__main__":
    main()
