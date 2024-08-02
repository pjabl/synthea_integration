import os
import psycopg2
from psycopg2 import sql

class PostgresManager:
    def __init__(self, env_prefix=''):
        self.host = os.getenv(f'{env_prefix}DB_HOST')
        self.dbname = os.getenv(f'{env_prefix}DB_NAME')
        self.user = os.getenv(f'{env_prefix}DB_USER')
        self.password = os.getenv(f'{env_prefix}DB_PASS')
        self.connection = None

    def connect(self):
        if self.connection is None:
            self.connection = psycopg2.connect(
                host=self.host,
                dbname=self.dbname,
                user=self.user,
                password=self.password
            )

    def close(self):
        if self.connection is not None:
            self.connection.close()
            self.connection = None

    def execute_query(self, query, params=None):
        self.connect()
        try:
            with self.connection.cursor() as cur:
                cur.execute(query, params)
                return cur.fetchall()
        finally:
            self.close()

    def copy_data_to_csv(self, dest_csv_path, table=None, query=None):
        self.connect()
        try:
            if table:
                query = sql.SQL("COPY {table} TO STDOUT WITH CSV HEADER").format(
                    table=sql.Identifier(*table.split('.'))
                )
            elif query:
                query = sql.SQL("COPY ({query}) TO STDOUT WITH CSV HEADER").format(
                    query=sql.SQL(query)
                )
            else:
                raise ValueError("Either table or query must be provided.")

            with self.connection.cursor() as cur, open(dest_csv_path, 'w') as f:
                print(f"Executing query: {query.as_string(self.connection)}")
                cur.copy_expert(query.as_string(self.connection), f)
        finally:
            self.close()

    def copy_csv_to_db(self, table, src_csv_path):
        self.connect()
        try:
            query = sql.SQL("COPY {table} FROM STDIN WITH CSV HEADER").format(
                table=sql.Identifier(*table.split('.'))
            )
            with self.connection.cursor() as cur, open(src_csv_path, 'r') as f:
                print(f"Executing query: {query.as_string(self.connection)}")
                cur.copy_expert(query.as_string(self.connection), f)
        finally:
            self.close()

    def table_exists(self, schema, table_name):
        self.connect()
        try:
            query = """
                SELECT EXISTS (
                    SELECT 1 
                    FROM information_schema.tables 
                    WHERE table_schema = %s 
                    AND table_name = %s
                )
            """
            with self.connection.cursor() as cur:
                cur.execute(query, (schema, table_name))
                return cur.fetchone()[0]
        finally:
            self.close()

    def truncate_table(self, schema, table):
        self.connect()
        try:
            query = sql.SQL("TRUNCATE TABLE {schema}.{table}").format(
                schema=sql.Identifier(schema),
                table=sql.Identifier(table)
            )
            with self.connection.cursor() as cur:
                print(f"Executing query: {query.as_string(self.connection)}")
                cur.execute(query)
                self.connection.commit()
        finally:
            self.close()

    def terminate_idle_connections(self):
        self.connect()
        try:
            terminate_query = """
            SELECT pg_terminate_backend(pid)
            FROM pg_stat_activity
            WHERE state = 'idle' 
            AND pid <> pg_backend_pid();
            """
            with self.connection.cursor() as cur:
                cur.execute(terminate_query)
                self.connection.commit()
        finally:
            self.close()
