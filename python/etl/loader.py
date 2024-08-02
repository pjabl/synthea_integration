import os
from postgres_manager import PostgresManager
from fetch_patient_ids import fetch_patient_ids
from custom_logger import CustomLogger

class Loader:
    def __init__(self, remote_manager: PostgresManager, local_manager: PostgresManager, logger: CustomLogger):
        self.remote_manager = remote_manager
        self.local_manager = local_manager
        self.logger = logger

    def copy_table_data(self, table, schema='patients_data'):
        csv_path = f"/tmp/{table}.csv"  # Temporary path to store the CSV file
        self.logger.info(f"Checking if table {schema}.{table} exists in the remote database.", stage="ETL", status="started")
        if not self.remote_manager.table_exists(schema, table):
            self.logger.error(f"Table {schema}.{table} does not exist in the remote database.", stage="ETL", status="failed")
            return
        self.remote_manager.copy_data_to_csv(csv_path, table=f"{schema}.{table}")

        self.logger.info(f"Checking if table {schema}.{table} exists in the local database.", stage="ETL", status="started")
        if self.local_manager.table_exists(schema, table):
            self.logger.info(f"Table {schema}.{table} exists. Proceeding with TRUNCATE and COPY.", stage="ETL", status="started")
            self.local_manager.truncate_table(schema, table)  # Truncate the table before loading new data
            self.local_manager.copy_csv_to_db(f"{schema}.{table}", csv_path)
        else:
            self.logger.warning(f"Table {schema}.{table} does not exist in the local database.", stage="ETL", status="warning")
        os.remove(csv_path)  # Clean up the temporary CSV file

    def copy_query_data(self, query, table, schema='patients_data'):
        csv_path = f"/tmp/{table}.csv"  # Temporary path to store the CSV file
        self.remote_manager.copy_data_to_csv(csv_path, query=query)

        self.logger.info(f"Checking if table {schema}.{table} exists in the local database.", stage="ETL", status="started")
        if self.local_manager.table_exists(schema, table):
            self.logger.info(f"Table {schema}.{table} exists. Proceeding with TRUNCATE and COPY.", stage="ETL", status="started")
            self.local_manager.truncate_table(schema, table)  # Truncate the table before loading new data
            self.local_manager.copy_csv_to_db(f"{schema}.{table}", csv_path)
        else:
            self.logger.warning(f"Table {schema}.{table} does not exist in the local database.", stage="ETL", status="warning")
        os.remove(csv_path)  # Clean up the temporary CSV file

    def process_tables(self, tables, patient_ids=None, schema='patients_data'):
        try:
            for table, config in tables.items():
                self.logger.info(f"Copying data for table: {table}", stage="ETL", status="started")
                if 'where_id' in config and patient_ids:
                    where_id = config['where_id']
                    formatted_ids = ', '.join(f"'{id}'" for id in patient_ids)
                    query = f"SELECT * FROM {schema}.{table} WHERE {where_id} IN ({formatted_ids})"
                    self.logger.info(f"Generated query for table {table}: {query}", stage="ETL", status="started")
                    self.copy_query_data(query, table, schema=schema)
                else:
                    self.copy_table_data(table, schema=schema)
        finally:
            self.close()

    def close(self):
        self.remote_manager.close()
        self.local_manager.close()

if __name__ == "__main__":
    remote_manager = PostgresManager(env_prefix='REMOTE_')
    local_manager = PostgresManager()

    logger = CustomLogger(name="ETLLogger", postgres_manager=remote_manager, process_id='c1de4c90-f0f6-484c-a833-9ee97ee45b8d', component='TEE')

    loader = Loader(remote_manager, local_manager, logger)

    tables_to_copy = {"patients": {"where_id": "id"}, "organizations": {}}
    patient_ids = fetch_patient_ids(source_manager=remote_manager, process_id='c1de4c90-f0f6-484c-a833-9ee97ee45b8d')

    loader.process_tables(tables=tables_to_copy, patient_ids=patient_ids)
