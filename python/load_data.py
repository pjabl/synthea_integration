import os
import pandas as pd
from sqlalchemy import create_engine, text
from google.cloud import secretmanager

# Initialize the Secret Manager client
def get_secret(secret_name):
    client = secretmanager.SecretManagerServiceClient()
    project_id = os.environ['GOOGLE_CLOUD_PROJECT']
    name = f"projects/{project_id}/secrets/{secret_name}/versions/latest"
    response = client.access_secret_version(name=name)
    return response.payload.data.decode('UTF-8')

# Get database credentials
def get_db_credentials():
    user = get_secret('db_user')
    password = get_secret('db_password')
    return user, password

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
        with open(ddl_file_path, 'r') as ddl_file:
            ddl_statements = ddl_file.read()
            conn.execute(text(ddl_statements))

# Load CSV data into the database
def load_csv_to_db(engine, csv_file_path, table_name, schema):
    df = pd.read_csv(csv_file_path)
    df.to_sql(table_name, engine, schema=schema, if_exists='replace', index=False)

def main():
    user, password = get_db_credentials()
    host = '10.49.0.3'  # Use the private IP address provided
    db_name = 'YOUR_DATABASE_NAME'
    schema = 'patients_data'
    ddl_file_path = 'path/to/your/ddl_file.sql'
    csv_files = ['path/to/csv1.csv', 'path/to/csv2.csv']  # Add paths to all your CSV files

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
