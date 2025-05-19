-- Assessment_Q2.sql
-- Transaction frequency analysis: average per customer per month and categorization

WITH monthly_txns AS (
    SELECT 
        owner_id,
        DATE_TRUNC('month', created_at) AS txn_month,
        COUNT(*) AS txn_count
    FROM savings_savingsaccount
    GROUP BY owner_id, DATE_TRUNC('month', created_at)
),
avg_txns_per_customer AS (
    SELECT 
        owner_id,
        AVG(txn_count) AS avg_txns_per_month
    FROM monthly_txns
    GROUP BY owner_id
),
categorized AS (
    SELECT 
        CASE
            WHEN avg_txns_per_month >= 10 THEN 'High Frequency'
            WHEN avg_txns_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category,
        avg_txns_per_month
    FROM avg_txns_per_customer
)
SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_txns_per_month), 1) AS avg_transactions_per_month
FROM categorized
GROUP BY frequency_category
ORDER BY customer_count DESC;
