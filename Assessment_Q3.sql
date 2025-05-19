-- Assessment_Q3.sql
-- Find active accounts with no transactions in the last 365 days

WITH latest_txn AS (
    SELECT 
        id AS plan_id,
        owner_id,
        CASE 
            WHEN is_regular_savings = 1 THEN 'Savings'
            WHEN is_a_fund = 1 THEN 'Investment'
            ELSE 'Unknown'
        END AS type,
        MAX(created_at) AS last_transaction_date
    FROM savings_savingsaccount
    GROUP BY id, owner_id, is_regular_savings, is_a_fund
),
inactive AS (
    SELECT *,
        DATE_PART('day', CURRENT_DATE - last_transaction_date) AS inactivity_days
    FROM latest_txn
)
SELECT 
    plan_id,
    owner_id,
    type,
    last_transaction_date::date,
    inactivity_days
FROM inactive
WHERE inactivity_days > 365
ORDER BY inactivity_days DESC;
