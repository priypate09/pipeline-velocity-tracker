-- ========================================================================
-- Stage Velocity Analysis 
-- ========================================================================

-- Average days per stage across all closed deals
SELECT 
    stage,
    COUNT(*) as num_transitions,
    ROUND(AVG(days_in_stage)::numeric, 1) as avg_days,
    MIN(days_in_stage) as min_days,
    MAX(days_in_stage) as max_days
FROM stage_history
WHERE days_in_stage IS NOT NULL
  AND stage NOT IN ('Closed Won', 'Closed Lost')
GROUP BY stage
ORDER BY 
    CASE stage
        WHEN 'Lead' THEN 1
        WHEN 'Qualified' THEN 2
        WHEN 'Meeting Scheduled' THEN 3
        WHEN 'Proposal Sent' THEN 4
        WHEN 'Negotiation' THEN 5
    END;

-- ========================================================================
-- Total Cycle Time by Outcome
-- ========================================================================

SELECT 
    o.status,
    COUNT(DISTINCT o.opportunity_id) as num_deals,
    ROUND(AVG(o.close_date - o.created_date)::numeric, 1) as avg_total_days,
    MIN(o.close_date - o.created_date) as min_days,
    MAX(o.close_date - o.created_date) as max_days
FROM opportunities o
WHERE o.status IN ('Won', 'Lost')
GROUP BY o.status;

-- ========================================================================
-- Velocity by Deal Size
-- ========================================================================

SELECT 
    CASE 
        WHEN o.deal_size < 100000 THEN 'Small (<100K)'
        WHEN o.deal_size < 250000 THEN 'Medium (100K-250K)'
        WHEN o.deal_size < 500000 THEN 'Large (250K-500K)'
        ELSE 'Enterprise (500K+)'
    END as deal_size_category,
    COUNT(DISTINCT o.opportunity_id) as num_deals,
    ROUND(AVG(o.close_date - o.created_date)::numeric, 1) as avg_days_to_close
FROM opportunities o
WHERE o.status IN ('Won', 'Lost')
GROUP BY deal_size_category
ORDER BY MIN(o.deal_size);

-- ========================================================================
-- Velocity Trends Over Time
-- ========================================================================

SELECT 
    DATE_TRUNC('month', o.created_date) as month,
    COUNT(*) as deals_created,
    ROUND(AVG(o.close_date - o.created_date)::numeric, 1) as avg_days_to_close
FROM opportunities o
WHERE o.status IN ('Won', 'Lost')
GROUP BY DATE_TRUNC('month', o.created_date)
ORDER BY month;