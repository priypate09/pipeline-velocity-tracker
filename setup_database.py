"""
Setting up PostgreSQL database using DatabaseManager
"""
import os
import sys
from src.db_manager import DatabaseManager


def setup_database():
    print("="*60)
    print("Database Setup")
    print("="*60)
    
    try:
        db = DatabaseManager()
        print("\nConnected to database")
        
        # Create tables
        print("\nCreating tables...")
        db.run_sql_file('sql/schema.sql')
        print("Tables created")
        
        # Load data
        print("\nLoading data...")
        db.run_sql_file('sql/load_sample_data.sql')
        print("Data loaded")
        
        # Verify
        result, _ = db.run_query("SELECT COUNT(*) FROM opportunities")
        opp_count = result[0][0]
        
        result, _ = db.run_query("SELECT COUNT(*) FROM stage_history")
        stage_count = result[0][0]
        
        print("\n" + "="*60)
        print(f"Complete! {opp_count} opportunities, {stage_count} stage records")
        print("="*60)
    
    except Exception as e:
        print(f"\nError: {e}")
        print("\nMake sure:")
        print("1. PostgreSQL is running")
        print("2. Database 'pipeline_velocity' exists")
        print("3. .env has correct credentials")


def main():
    setup_database()

if __name__ == "__main__":
    main()