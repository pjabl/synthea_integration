import logging
import json
from datetime import datetime
from postgres_manager import PostgresManager

class DBLoggingHandler(logging.Handler):
    def __init__(self, postgres_manager: PostgresManager, schema: str = 'log'):
        super().__init__()
        self.postgres_manager = postgres_manager
        self.schema = schema
        self.postgres_manager.connect()  # Ensure the connection is established

    def emit(self, record):
        if self.postgres_manager.connection is None:
            self.postgres_manager.connect()

        log_entry = self.format(record)
        cursor = self.postgres_manager.connection.cursor()
        insert_query = """
            INSERT INTO {}.execution_log (process_id, component, stage, status, log_timestamp, log_level, log_message, details, user_id, member)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """.format(self.schema)
        cursor.execute(insert_query, (
            log_entry.get('process_id'),
            log_entry.get('component'),
            log_entry.get('stage'),
            log_entry.get('status'),
            log_entry.get('log_timestamp'),
            log_entry.get('log_level'),
            log_entry.get('log_message'),
            json.dumps(log_entry.get('details')),
            log_entry.get('user_id'),
            log_entry.get('member')
        ))
        self.postgres_manager.connection.commit()
        cursor.close()

    def format(self, record):
        return {
            'process_id': record.process_id,
            'component': record.component,
            'stage': record.stage,
            'status': record.status,
            'log_timestamp': datetime.utcnow(),
            'log_level': record.levelname.lower(),
            'log_message': record.getMessage(),
            'details': record.details,
            'user_id': record.user_id,
            'member': record.member
        }
