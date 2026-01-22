"""
Main entry point for pipeline velocity analysis
"""
import sys
import os

# Add project root to Python path
project_root = os.path.abspath(os.path.dirname(__file__))
sys.path.insert(0, project_root)

def main():
    """Run all analyses"""
    try:
        from src.query_runner import run_velocity_analysis, run_bottleneck_analysis
        
        print("="*70)
        print("PIPELINE VELOCITY TRACKER")
        print("="*70)
        
        # Run velocity analysis
        run_velocity_analysis()
        
        # Run bottleneck analysis
        run_bottleneck_analysis()
    
    except ImportError as e:
        print(f"Import Error: {e}")
        print("\nTroubleshooting Steps:")
        print("1. Ensure all dependencies are installed")
        print("2. Verify project structure")
        print("3. Check Python path")
    
    except Exception as e:
        print(f"An error occurred: {e}")
        print("\nDetailed Error Information:")
        import traceback
        traceback.print_exc()

if __name__ == "__main__":
    main()