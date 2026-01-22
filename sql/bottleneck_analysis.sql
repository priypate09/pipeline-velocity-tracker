-- ========================================================================
-- Bottleneck Detection
-- ========================================================================

-- Stages slower than threshold
WITH stage_averages AS (
    SELECT 
        stage,
        AVG(days_in_stage) as avg_days,
        COUNT(*) as num_transitions
    FROM stage_history
    WHERE days_in_stage IS NOT NULL
    GROUP BY stage
)
SELECT 
    stage,
    ROUND(avg_days::numeric, 1) as avg_days_in_stage,
    num_transitions,
    CASE 
        WHEN avg_days > 30 THEN 'Critical Bottleneck'
        WHEN avg_days > 14 THEN 'Warning - Slow Stage'
        ELSE 'Normal Velocity'
    END as status
FROM stage_averages
WHERE stage NOT IN ('Closed Won', 'Closed Lost')
ORDER BY avg_days DESC;

-- ========================================================================
-- Individual Deals Stuck in Stages
-- ========================================================================

SELECT 
    sh.opportunity_id,
    o.opportunity_name,
    o.owner_name,
    sh.stage as current_stage,
    sh.entered_date,
    COALESCE(
        sh.days_in_stage,
        CURRENT_DATE - sh.entered_date
    ) as days_in_current_stage,
    o.deal_size,
    CASE 
        WHEN COALESCE(sh.days_in_stage, CURRENT_DATE - sh.entered_date) > 30 THEN 'Urgent'
        WHEN COALESCE(sh.days_in_stage, CURRENT_DATE - sh.entered_date) > 14 THEN 'Warning'
        ELSE 'OK'
    END as alert_status
FROM stage_history sh
JOIN opportunities o ON sh.opportunity_id = o.opportunity_id
WHERE sh.exited_date IS NULL
  AND o.status = 'Open'
  AND sh.stage NOT IN ('Lead', 'Qualified')
ORDER BY days_in_current_stage DESC;

-- ========================================================================
-- Stage-to-Stage Conversion Rates
-- ========================================================================

WITH stage_counts AS (
    SELECT 
        stage,
        COUNT(DISTINCT opportunity_id) as deals_entered
    FROM stage_history
    WHERE stage NOT IN ('Closed Won', 'Closed Lost')
    GROUP BY stage
),
next_stage_counts AS (
    SELECT 
        sh1.stage as from_stage,
        COUNT(DISTINCT sh1.opportunity_id) as deals_progressed
    FROM stage_history sh1
    WHERE EXISTS (
        SELECT 1 
        FROM stage_history sh2 
        WHERE sh2.opportunity_id = sh1.opportunity_id 
          AND sh2.entered_date > sh1.entered_date
    )
    AND sh1.stage NOT IN ('Closed Won', 'Closed Lost')
    GROUP BY sh1.stage
)
SELECT 
    sc.stage,
    sc.deals_entered,
    COALESCE(nsc.deals_progressed, 0) as deals_progressed,
    ROUND(
        COALESCE(nsc.deals_progressed, 0)::numeric / sc.deals_entered * 100, 
        1
    ) as progression_rate_pct
FROM stage_counts sc
LEFT JOIN next_stage_counts nsc ON sc.stage = nsc.from_stage
ORDER BY 
    CASE sc.stage
        WHEN 'Lead' THEN 1
        WHEN 'Qualified' THEN 2
        WHEN 'Meeting Scheduled' THEN 3
        WHEN 'Proposal Sent' THEN 4
        WHEN 'Negotiation' THEN 5
    END;