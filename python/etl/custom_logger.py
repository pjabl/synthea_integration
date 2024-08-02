import logging
from db_logging_handler import DBLoggingHandler
from postgres_manager import PostgresManager

class CustomLogger:
    def __init__(self, name, postgres_manager: PostgresManager, process_id, component):
        self.logger = logging.getLogger(name)
        self.logger.setLevel(logging.DEBUG)
        
        console_handler = logging.StreamHandler()
        console_handler.setLevel(logging.DEBUG)
        
        db_handler = DBLoggingHandler(postgres_manager)
        db_handler.setLevel(logging.DEBUG)
        
        formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
        console_handler.setFormatter(formatter)
        db_handler.setFormatter(formatter)
        
        self.logger.addHandler(console_handler)
        self.logger.addHandler(db_handler)
        
        self.process_id = process_id
        self.component = component

    def log(self, level, message, stage, status, details=None, user_id=None, member=None):
        extra = {
            'process_id': self.process_id,
            'component': self.component,
            'stage': stage,
            'status': status,
            'details': details,
            'user_id': user_id,
            'member': member
        }
        self.logger.log(level, message, extra=extra)

    def debug(self, message, stage, status, details=None, user_id=None, member=None):
        self.log(logging.DEBUG, message, stage, status, details, user_id, member)

    def info(self, message, stage, status, details=None, user_id=None, member=None):
        self.log(logging.INFO, message, stage, status, details, user_id, member)

    def warning(self, message, stage, status, details=None, user_id=None, member=None):
        self.log(logging.WARNING, message, stage, status, details, user_id, member)

    def error(self, message, stage, status, details=None, user_id=None, member=None):
        self.log(logging.ERROR, message, stage, status, details, user_id, member)

    def critical(self, message, stage, status, details=None, user_id=None, member=None):
        self.log(logging.CRITICAL, message, stage, status, details, user_id, member)
