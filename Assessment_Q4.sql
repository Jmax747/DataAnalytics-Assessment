-- Assessment_Q4.sql
-- Estimate customer lifetime value using tenure and transaction volume

WITH transaction_summary AS (
    SELECT 
        owner_id AS customer_id,
        COUNT(*) AS total_transactions,
        SUM(confirmed_amount) AS total_value
    FROM savings_savingsaccount
    GROUP BY owner_id
),
user_tenure AS (
    SELECT 
        id AS customer_id,
        name,
        DATE_PART('month', AGE(CURRENT_DATE, date_joined)) AS tenure_months
    FROM users_customuser
),
clv AS (
    SELECT 
        u.customer_id,
        u.name,
        u.tenure_months,
        t.total_transactions,
        ROUND(((t.total_transactions::decimal / NULLIF(u.tenure_months, 0)) * 12) * (0.001), 2) AS estimated_clv
    FROM user_tenure u
    JOIN transaction_summary t ON u.customer_id = t.customer_id
)
SELECT *
FROM clv
ORDER BY estimated_clv DESC;
