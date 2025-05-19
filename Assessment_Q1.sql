-- Assessment_Q1.sql
-- Identify customers with both funded savings and investment plans
-- Show savings_count, investment_count, total_deposits

SELECT 
    u.id AS owner_id,
    u.name,
    COUNT(DISTINCT CASE WHEN p.plan_type = 'savings' AND p.status = 'funded' THEN p.id END) AS savings_count,
    COUNT(DISTINCT CASE WHEN p.plan_type = 'investment' AND p.status = 'funded' THEN p.id END) AS investment_count,
    COALESCE(SUM(s.amount), 0) AS total_deposits
FROM 
    users_customuser u
LEFT JOIN 
    plans_plan p ON u.id = p.owner_id
LEFT JOIN 
    savings_savingsaccount s ON u.id = s.owner_id
GROUP BY 
    u.id, u.name
HAVING 
    COUNT(DISTINCT CASE WHEN p.plan_type = 'savings' AND p.status = 'funded' THEN p.id END) >= 1
    AND
    COUNT(DISTINCT CASE WHEN p.plan_type = 'investment' AND p.status = 'funded' THEN p.id END) >= 1
ORDER BY 
    total_deposits DESC;
