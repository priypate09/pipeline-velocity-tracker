"""
Database Configuration Verification Script
"""
import os
import sys
from dotenv import load_dotenv

def verify_database_config():
    """
    Verify database configuration and provide detailed feedback
    """
    print("="*60)
    print("DATABASE CONFIGURATION VERIFICATION")
    print("="*60)
    
    # Load environment variables
    load_dotenv()
    
    # Database configuration keys
    config_keys = ['DB_HOST', 'DB_PORT', 'DB_NAME', 'DB_USER', 'DB_PASSWORD']
    
    # Check configuration
    config_issues = []
    
    print("Environment Variable Checks:")
    for key in config_keys:
        value = os.getenv(key)
        
        if not value:
            config_issues.append(f"❌ {key} is not set")
            print(f"  {key}: Not Set")
        elif key == 'DB_PASSWORD' and value in ['postgres', 'password', '']:
            config_issues.append(f"⚠️ {key} seems to be using a default/weak password")
            print(f"  {key}: Weak/Default Password Detected")
        else:
            print(f"  {key}: Set ✓")
    
    # Recommend .env file configuration
    if config_issues:
        print("\n⚠️ CONFIGURATION RECOMMENDATIONS:")
        print("1. Create or update .env file in project root")
        print("2. Add the following configuration:")
        print("""
DB_HOST=localhost
DB_PORT=5432
DB_NAME=pipeline_velocity
DB_USER=your_postgres_username
DB_PASSWORD=your_secure_password
        """)
        
        # Optional: Suggest PostgreSQL user creation
        print("\n3. Create a dedicated PostgreSQL user:")
        print("""
# Connect to PostgreSQL
psql -U postgres

# Create user and database
CREATE USER your_username WITH PASSWORD 'your_secure_password';
CREATE DATABASE pipeline_velocity;
GRANT ALL PRIVILEGES ON DATABASE pipeline_velocity TO your_username;
        """)
    
    # Return whether configuration is valid
    return len(config_issues) == 0

def main():
    is_config_valid = verify_database_config()
    
    if is_config_valid:
        print("\n✅ Database configuration looks good!")
        sys.exit(0)
    else:
        print("\n❌ Database configuration needs attention")
        sys.exit(1)

if __name__ == "__main__":
    main()