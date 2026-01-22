-- ========================================================================
-- Pipeline Velocity Tracker Database Schema
-- ========================================================================

-- Drop tables if they exist (for clean rebuild)
DROP TABLE IF EXISTS stage_history CASCADE;
DROP TABLE IF EXISTS opportunities CASCADE;

-- Opportunities table
CREATE TABLE opportunities (
    opportunity_id VARCHAR(50) PRIMARY KEY,
    opportunity_name VARCHAR(255) NOT NULL,
    account_name VARCHAR(255) NOT NULL,
    owner_name VARCHAR(100) NOT NULL,
    deal_size DECIMAL(18,2) NOT NULL,
    industry VARCHAR(100),
    region VARCHAR(100),
    created_date DATE NOT NULL,
    close_date DATE,
    current_stage VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('Open', 'Won', 'Lost'))
);

-- Stage history table (tracks movement through pipeline)
CREATE TABLE stage_history (
    id SERIAL PRIMARY KEY,
    opportunity_id VARCHAR(50) NOT NULL,
    stage VARCHAR(50) NOT NULL,
    entered_date DATE NOT NULL,
    exited_date DATE,
    days_in_stage INTEGER,
    FOREIGN KEY (opportunity_id) REFERENCES opportunities(opportunity_id)
);

-- Create indexes for better query performance
CREATE INDEX idx_opp_status ON opportunities(status);
CREATE INDEX idx_opp_stage ON opportunities(current_stage);
CREATE INDEX idx_stage_opp_id ON stage_history(opportunity_id);
CREATE INDEX idx_stage_name ON stage_history(stage);
CREATE INDEX idx_stage_dates ON stage_history(entered_date, exited_date);

-- Add comments for documentation
COMMENT ON TABLE opportunities IS 'Sales opportunities/deals';
COMMENT ON TABLE stage_history IS 'Tracks deals movement through pipeline stages';
