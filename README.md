# pipeline-velocity-tracker
SQL-based analysis of sales pipeline stage velocity and bottlenecks
# Pipeline Velocity Tracker

Analyzes how long sales deals spend in each pipeline stage and where they get stuck.

## What It Does

Tracks deals through stages:
Lead → Qualified → Meeting → Proposal → Negotiation → Closed

Shows:
- Average time in each stage
- Bottlenecks (where deals stall)
- Which deals are currently stuck
- Win vs lost velocity differences

## Why I Built This

Sales teams know their stages but don't measure velocity. A deal might sit in "Proposal Sent" for 40 days and nobody notices until it's too late. This tool makes those bottlenecks visible using SQL.

## Tech Stack

- PostgreSQL
- SQLAlchemy
- SQL - All analysis in SQL queries
- Python - Just runs queries and formats output

## Setup

### Install PostgreSQL

Download PostgreSQL 18 from https://www.postgresql.org/download/

Set a password during install (remember it!).

### Create Database

Using pgAdmin:
- Right-click Databases → Create → Database
- Name: `pipeline_velocity`


# Install dependencies
pip install -r requirements.txt

# Initialize database
python setup_database.py

# Run analysis
python main.py
```

## Example Output
```
Average Days Per Stage:
  Lead: 3.8 days
  Qualified: 10.1 days
  Proposal: 22.7 days (Warning - Slow)
  Negotiation: 38.4 days (Critical Bottleneck!)

Deals Currently Stuck:
  OPP-006: 37 days in Proposal (Urgent)
  OPP-003: 56 days in Negotiation (Warning)
```

## Project Structure
```bash
pipeline-velocity-tracker/
├── sql/
│   ├── schema.sql               # Table definitions
│   ├── load_sample_data.sql     # Sample data
│   ├── stage_velocity.sql       # Velocity queries
│   └── bottleneck_analysis.sql  # Bottleneck queries
├── src/
│   ├── db_manager.py            # Database connection
│   └── query_runner.py          # Run queries
├── main.py                      # Run analysis
└── setup_database.py            # Initialize database
```

## Use Cases

- Identify process bottlenecks
- Flag at-risk deals early

## License

MIT