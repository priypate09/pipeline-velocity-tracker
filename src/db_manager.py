"""
Simple database manager using SQLAlchemy
"""
from sqlalchemy import create_engine, text
import config

class DatabaseManager:
    """Manages PostgreSQL connection"""
    
    def __init__(self):
        # Create connection string
        url = (
            f"postgresql://{config.DB_CONFIG['user']}:{config.DB_CONFIG['password']}"
            f"@{config.DB_CONFIG['host']}:{config.DB_CONFIG['port']}"
            f"/{config.DB_CONFIG['database']}"
        )
        self.engine = create_engine(url)
    
    def run_query(self, query):
        """Run a SQL query and return results"""
        with self.engine.connect() as conn:
            result = conn.execute(text(query))
            if result.returns_rows:
                return result.fetchall(), list(result.keys())
            return None, None
    
    def run_sql_file(self, filepath):
        """Run SQL from a file"""
        with open(filepath, 'r') as f:
            sql = f.read()
        
        with self.engine.connect() as conn:
            conn.execute(text(sql))
            conn.commit()

# Ensure DatabaseManager is directly importable
__all__ = ['DatabaseManager']
