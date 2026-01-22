"""
Configuration for pipeline velocity analysis
"""
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Database connection (PostgreSQL)
DB_CONFIG = {
    'host': os.getenv('DB_HOST', 'localhost'),
    'port': os.getenv('DB_PORT', '5432'),
    'database': os.getenv('DB_NAME', 'pipeline_velocity'),
    'user': os.getenv('DB_USER', 'postgres'),
    'password': os.getenv('DB_PASSWORD', 'postgres')
}

# Validate database configuration
def validate_db_config():
    """Validate database configuration"""
    missing_config = [
        key for key, value in DB_CONFIG.items() 
        if not value or value == 'postgres'
    ]
    
    if missing_config:
        print("WARNING: The following database configuration is missing or using default:")
        for key in missing_config:
            print(f"  - {key}")
        print("\nPlease update your .env file with correct database credentials.")

# Run validation on import
validate_db_config()

# Pipeline stages (in order)
PIPELINE_STAGES = [
    'Lead',
    'Qualified',
    'Meeting Scheduled',
    'Proposal Sent',
    'Negotiation',
    'Closed Won',
    'Closed Lost'
]

# Analysis settings
MIN_DAYS_FOR_ANALYSIS = 30
SLOW_STAGE_THRESHOLD = 14