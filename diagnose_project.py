"""
Comprehensive Project Diagnostics
"""
import os
import sys
import importlib
import traceback
from dotenv import load_dotenv

def check_python_environment():
    print("="*60)
    print("PYTHON ENVIRONMENT")
    print("="*60)
    print(f"Python Version: {sys.version}")
    print(f"Python Executable: {sys.executable}")
    print(f"Current Working Directory: {os.getcwd()}")
    
    # Check virtual environment
    if hasattr(sys, 'real_prefix') or (hasattr(sys, 'base_prefix') and sys.base_prefix != sys.prefix):
        print("✓ Virtual Environment: Active")
    else:
        print("✗ Virtual Environment: Not Active")

def check_dependencies():
    print("\n" + "="*60)
    print("DEPENDENCY CHECK")
    print("="*60)
    
    dependencies = [
        'sqlalchemy', 
        'psycopg2', 
        'dotenv'
    ]
    
    for dep in dependencies:
        try:
            importlib.import_module(dep.replace('-', '_'))
            print(f"✓ {dep} is installed")
        except ImportError:
            print(f"✗ {dep} is NOT installed")
            print(f"  Install with: pip install {dep}")

def check_project_imports():
    print("\n" + "="*60)
    print("PROJECT IMPORTS DIAGNOSTIC")
    print("="*60)
    
    # List of modules to check
    modules_to_check = [
        'src.db_manager',
        'config'
    ]
    
    for module_name in modules_to_check:
        try:
            module = importlib.import_module(module_name)
            print(f"✓ Successfully imported {module_name}")
            print(f"  Location: {module.__file__}")
        except Exception as e:
            print(f"✗ Failed to import {module_name}")
            print("  Error Details:")
            print(traceback.format_exc())

def check_environment_variables():
    print("\n" + "="*60)
    print("ENVIRONMENT VARIABLES")
    print("="*60)
    
    # Load environment variables
    load_dotenv()
    
    # Import config to trigger dotenv
    import config
    
    # Check DB configuration
    print("Database Configuration:")
    for key, value in config.DB_CONFIG.items():
        # Mask password
        display_value = '****' if key == 'password' else value
        print(f"  {key}: {display_value}")
    
    # Additional environment variable checks
    print("\nEnvironment Variable Checks:")
    env_vars = ['DB_HOST', 'DB_PORT', 'DB_NAME', 'DB_USER', 'DB_PASSWORD']
    
    for var in env_vars:
        value = os.getenv(var, 'Not Set')
        print(f"  {var}: {value}")

def check_project_structure():
    print("\n" + "="*60)
    print("PROJECT STRUCTURE")
    print("="*60)
    
    required_files = [
        'setup_database.py',
        'main.py',
        'config.py',
        'src/db_manager.py',
        'src/query_runner.py',
        'src/__init__.py',
        'sql/schema.sql',
        'sql/load_sample_data.sql'
    ]
    
    for file in required_files:
        if os.path.exists(file):
            print(f"✓ {file} exists")
        else:
            print(f"✗ {file} is MISSING")

def check_database_connection():
    print("\n" + "="*60)
    print("DATABASE CONNECTION TEST")
    print("="*60)
    
    try:
        # Try to import and test database connection
        from src.db_manager import DatabaseManager
        
        db = DatabaseManager()
        result, cols = db.run_query("SELECT version();")
        
        print("✓ Database Connection Successful!")
        print(f"PostgreSQL Version: {result[0][0]}")
    
    except ImportError:
        print("✗ Cannot import DatabaseManager")
        print("  Check your src/db_manager.py file")
    except Exception as e:
        print(f"✗ Database Connection Failed: {e}")
        print("Troubleshooting Steps:")
        print("1. Ensure PostgreSQL is running")
        print("2. Verify database credentials")
        print("3. Check connection string in config.py")

def main():
    print("PIPELINE VELOCITY TRACKER - COMPREHENSIVE DIAGNOSTICS")
    
    check_python_environment()
    check_dependencies()
    check_project_structure()
    check_environment_variables()
    check_project_imports()
    check_database_connection()

if __name__ == "__main__":
    main()