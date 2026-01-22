"""
Run SQL queries and display results
"""
import os
import sys

# Add project root to Python path
project_root = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
sys.path.insert(0, project_root)

from src.db_manager import DatabaseManager

def print_results(results, columns, title):
    """Print query results as a table"""
    print("\n" + "-"*70)
    print(title)
    print("-"*70)
    
    if not results:
        print("No results")
        return
    
    # Print header
    header = " | ".join(str(col).ljust(15) for col in columns)
    print(header)
    print("-" * len(header))
    
    # Print rows
    for row in results:
        print(" | ".join(str(val).ljust(15) for val in row))

def run_velocity_analysis():
    """Run velocity queries from SQL file"""
    try:
        db = DatabaseManager()
        
        print("\n" + "="*70)
        print("STAGE VELOCITY ANALYSIS")
        print("="*70)
        
        # Construct the full path to the SQL file
        sql_path = os.path.join(project_root, 'sql', 'stage_velocity.sql')
        
        if not os.path.exists(sql_path):
            print(f"Error: SQL file not found at {sql_path}")
            return
        
        with open(sql_path, 'r') as f:
            sql_content = f.read()
        
        # Split into separate queries
        queries = [q.strip() for q in sql_content.split(';') if q.strip() and 'SELECT' in q.upper()]
        
        titles = [
            "Average Days Per Stage",
            "Cycle Time by Outcome",
            "Velocity by Deal Size",
            "Velocity Trends Over Time"
        ]
        
        for query, title in zip(queries, titles):
            try:
                results, columns = db.run_query(query)
                if results:
                    print_results(results, columns, title)
            except Exception as e:
                print(f"\nError in {title}: {e}")
    
    except Exception as e:
        print(f"Velocity Analysis Error: {e}")
        import traceback
        traceback.print_exc()

def run_bottleneck_analysis():
    """Run bottleneck queries from SQL file"""
    try:
        db = DatabaseManager()
        
        print("\n" + "="*70)
        print("BOTTLENECK ANALYSIS")
        print("="*70)
        
        # Construct the full path to the SQL file
        sql_path = os.path.join(project_root, 'sql', 'bottleneck_analysis.sql')
        
        if not os.path.exists(sql_path):
            print(f"Error: SQL file not found at {sql_path}")
            return
        
        with open(sql_path, 'r') as f:
            sql_content = f.read()
        
        # Split into separate queries
        queries = [q.strip() for q in sql_content.split(';') if q.strip() and 'SELECT' in q.upper()]
        
        titles = [
            "Stage Velocity Status",
            "Deals Currently Stuck",
            "Stage Progression Rates"
        ]
        
        for query, title in zip(queries, titles):
            try:
                results, columns = db.run_query(query)
                if results:
                    print_results(results, columns, title)
            except Exception as e:
                print(f"\nError in {title}: {e}")
    
    except Exception as e:
        print(f"Bottleneck Analysis Error: {e}")
        import traceback
        traceback.print_exc()

# Allow direct running of the script for testing
if __name__ == "__main__":
    run_velocity_analysis()
    run_bottleneck_analysis()