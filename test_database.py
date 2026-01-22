"""
Comprehensive Database Connection Test
"""
import sys
import os

# Add project root to Python path
project_root = os.path.abspath(os.path.join(os.path.dirname(__file__)))
sys.path.insert(0, project_root)

def test_database_connection():
    """
    Perform comprehensive database connection test
    """
    print("="*60)
    print("DATABASE CONNECTION DIAGNOSTIC")
    print("="*60)
    
    try:
        # Import config to load environment variables
        import config
        print("✓ Configuration loaded successfully")
        
        # Import DatabaseManager
        from src.db_manager import DatabaseManager
        print("✓ DatabaseManager imported successfully")
        
        # Create database manager
        db = DatabaseManager()
        print("✓ Database Manager instantiated")
        
        # Test connection with version query
        result, cols = db.run_query("SELECT version();")
        print("✓ Connection Successful!")
        print(f"PostgreSQL Version: {result[0][0]}")
        
        # Additional diagnostics
        print("\nDatabase Configuration:")
        for key, value in config.DB_CONFIG.items():
            # Mask sensitive information
            display_value = '****' if key == 'password' else value
            print(f"  {key}: {display_value}")
    
    except ImportError as e:
        print(f"✗ Import Error: {e}")
        print("Possible issues:")
        print("1. Check import paths")
        print("2. Verify src/__init__.py exists")
    
    except Exception as e:
        print(f"✗ Connection Test Failed: {e}")
        print("\nTroubleshooting Steps:")
        print("1. Ensure PostgreSQL is running")
        print("2. Verify database credentials")
        print("3. Check .env file configuration")
        print("4. Verify database 'pipeline_velocity' exists")

if __name__ == "__main__":
    test_database_connection()