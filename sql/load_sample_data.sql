-- Sample Data for Pipeline Velocity Analysis
-- All dates and calculations verified for accuracy

-- Sample opportunities (10 deals with varied outcomes)
INSERT INTO opportunities (opportunity_id, opportunity_name, account_name, owner_name, deal_size, industry, region, created_date, close_date, current_stage, status) VALUES
('OPP-001', 'Enterprise Software Deal', 'Acme Corp', 'Sarah Miller', 250000.00, 'Technology', 'North America', '2024-09-01', '2024-12-15', 'Closed Won', 'Won'),
('OPP-002', 'Cloud Migration Project', 'TechStart Inc', 'John Davis', 180000.00, 'Technology', 'North America', '2024-09-05', '2024-11-20', 'Closed Won', 'Won'),
('OPP-003', 'Analytics Platform', 'DataCo', 'Maria Garcia', 320000.00, 'Financial Services', 'Europe', '2024-09-10', NULL, 'Negotiation', 'Open'),
('OPP-004', 'Security Implementation', 'SecureBank', 'James Wilson', 450000.00, 'Financial Services', 'North America', '2024-09-15', '2024-12-01', 'Closed Lost', 'Lost'),
('OPP-005', 'CRM Integration', 'SalesHub', 'Emily Chen', 95000.00, 'Technology', 'Asia Pacific', '2024-10-01', '2024-12-10', 'Closed Won', 'Won'),
('OPP-006', 'Data Warehouse Setup', 'Analytics Pro', 'Michael Brown', 280000.00, 'Healthcare', 'North America', '2024-10-05', NULL, 'Proposal Sent', 'Open'),
('OPP-007', 'Mobile App Development', 'AppMakers', 'Lisa Anderson', 150000.00, 'Retail', 'Europe', '2024-10-10', NULL, 'Meeting Scheduled', 'Open'),
('OPP-008', 'AI Implementation', 'FutureTech', 'David Lee', 500000.00, 'Technology', 'North America', '2024-10-15', NULL, 'Qualified', 'Open'),
('OPP-009', 'Customer Portal', 'ServiceNow Inc', 'Sarah Miller', 120000.00, 'Technology', 'North America', '2024-11-01', '2024-12-20', 'Closed Won', 'Won'),
('OPP-010', 'Network Upgrade', 'ConnectCorp', 'John Davis', 200000.00, 'Manufacturing', 'Europe', '2024-11-05', NULL, 'Negotiation', 'Open');

-- ========================================================================
-- Stage History Data
-- Each entry shows when a deal entered/exited a stage
-- days_in_stage = number of days spent in that stage
-- ========================================================================

-- OPP-001: Closed Won in 105 days (Slow - bottleneck in Negotiation)
INSERT INTO stage_history (opportunity_id, stage, entered_date, exited_date, days_in_stage) VALUES
('OPP-001', 'Lead', '2024-09-01', '2024-09-05', 4),
('OPP-001', 'Qualified', '2024-09-05', '2024-09-12', 7),
('OPP-001', 'Meeting Scheduled', '2024-09-12', '2024-09-20', 8),
('OPP-001', 'Proposal Sent', '2024-09-20', '2024-10-10', 20),
('OPP-001', 'Negotiation', '2024-10-10', '2024-12-15', 66),  -- Bottleneck: 66 days!
('OPP-001', 'Closed Won', '2024-12-15', NULL, NULL);

-- OPP-002: Closed Won in 76 days (Fast - good velocity throughout)
INSERT INTO stage_history (opportunity_id, stage, entered_date, exited_date, days_in_stage) VALUES
('OPP-002', 'Lead', '2024-09-05', '2024-09-08', 3),
('OPP-002', 'Qualified', '2024-09-08', '2024-09-18', 10),
('OPP-002', 'Meeting Scheduled', '2024-09-18', '2024-09-25', 7),
('OPP-002', 'Proposal Sent', '2024-09-25', '2024-10-15', 20),
('OPP-002', 'Negotiation', '2024-10-15', '2024-11-20', 36),
('OPP-002', 'Closed Won', '2024-11-20', NULL, NULL);

-- OPP-003: Open deal, 56 days so far, currently in Negotiation
INSERT INTO stage_history (opportunity_id, stage, entered_date, exited_date, days_in_stage) VALUES
('OPP-003', 'Lead', '2024-09-10', '2024-09-15', 5),
('OPP-003', 'Qualified', '2024-09-15', '2024-09-28', 13),
('OPP-003', 'Meeting Scheduled', '2024-09-28', '2024-10-08', 10),
('OPP-003', 'Proposal Sent', '2024-10-08', '2024-11-05', 28),  -- Slower proposal stage
('OPP-003', 'Negotiation', '2024-11-05', NULL, NULL);  -- Currently here

-- OPP-004: Closed Lost in 77 days (Red flag: 44 days stuck in Proposal)
INSERT INTO stage_history (opportunity_id, stage, entered_date, exited_date, days_in_stage) VALUES
('OPP-004', 'Lead', '2024-09-15', '2024-09-20', 5),
('OPP-004', 'Qualified', '2024-09-20', '2024-10-05', 15),
('OPP-004', 'Meeting Scheduled', '2024-10-05', '2024-10-12', 7),
('OPP-004', 'Proposal Sent', '2024-10-12', '2024-11-25', 44),  -- Major bottleneck!
('OPP-004', 'Negotiation', '2024-11-25', '2024-12-01', 6),
('OPP-004', 'Closed Lost', '2024-12-01', NULL, NULL);

-- OPP-005: Closed Won in 70 days (Fastest - quick early stages)
INSERT INTO stage_history (opportunity_id, stage, entered_date, exited_date, days_in_stage) VALUES
('OPP-005', 'Lead', '2024-10-01', '2024-10-03', 2),           -- Very fast
('OPP-005', 'Qualified', '2024-10-03', '2024-10-10', 7),
('OPP-005', 'Meeting Scheduled', '2024-10-10', '2024-10-15', 5),  -- Fast
('OPP-005', 'Proposal Sent', '2024-10-15', '2024-11-01', 17),     -- Quick
('OPP-005', 'Negotiation', '2024-11-01', '2024-12-10', 39),
('OPP-005', 'Closed Won', '2024-12-10', NULL, NULL);

-- OPP-006: Open deal, 27 days so far, currently in Proposal
INSERT INTO stage_history (opportunity_id, stage, entered_date, exited_date, days_in_stage) VALUES
('OPP-006', 'Lead', '2024-10-05', '2024-10-10', 5),
('OPP-006', 'Qualified', '2024-10-10', '2024-10-22', 12),
('OPP-006', 'Meeting Scheduled', '2024-10-22', '2024-11-01', 10),
('OPP-006', 'Proposal Sent', '2024-11-01', NULL, NULL);  -- Currently here

-- OPP-007: Open deal, 18 days so far, currently in Meeting Scheduled
INSERT INTO stage_history (opportunity_id, stage, entered_date, exited_date, days_in_stage) VALUES
('OPP-007', 'Lead', '2024-10-10', '2024-10-15', 5),
('OPP-007', 'Qualified', '2024-10-15', '2024-10-28', 13),
('OPP-007', 'Meeting Scheduled', '2024-10-28', NULL, NULL);  -- Currently here

-- OPP-008: Open deal, 5 days so far, currently in Qualified
INSERT INTO stage_history (opportunity_id, stage, entered_date, exited_date, days_in_stage) VALUES
('OPP-008', 'Lead', '2024-10-15', '2024-10-20', 5),
('OPP-008', 'Qualified', '2024-10-20', NULL, NULL);  -- Currently here

-- OPP-009: Closed Won in 49 days (Very fast - small deal, quick execution)
INSERT INTO stage_history (opportunity_id, stage, entered_date, exited_date, days_in_stage) VALUES
('OPP-009', 'Lead', '2024-11-01', '2024-11-03', 2),
('OPP-009', 'Qualified', '2024-11-03', '2024-11-08', 5),
('OPP-009', 'Meeting Scheduled', '2024-11-08', '2024-11-12', 4),
('OPP-009', 'Proposal Sent', '2024-11-12', '2024-11-25', 13),
('OPP-009', 'Negotiation', '2024-11-25', '2024-12-20', 25),
('OPP-009', 'Closed Won', '2024-12-20', NULL, NULL);

-- OPP-010: Open deal, 30 days so far, currently in Negotiation
INSERT INTO stage_history (opportunity_id, stage, entered_date, exited_date, days_in_stage) VALUES
('OPP-010', 'Lead', '2024-11-05', '2024-11-08', 3),
('OPP-010', 'Qualified', '2024-11-08', '2024-11-18', 10),
('OPP-010', 'Meeting Scheduled', '2024-11-18', '2024-11-25', 7),
('OPP-010', 'Proposal Sent', '2024-11-25', '2024-12-05', 10),
('OPP-010', 'Negotiation', '2024-12-05', NULL, NULL);  -- Currently here