# DataAnalytics-Assessment

This repository contains my solutions for the Cowrywise SQL Proficiency Assessment.

---

## Assessment_Q1.sql — High-Value Customers with Multiple Products
- **Approach**: Joined `users_customuser`, `plans_plan`, and `savings_savingsaccount`. Used `CASE WHEN` inside `COUNT()` to count funded savings and investment plans. Calculated total deposits with `SUM()` and sorted by total amount.
- **Challenge**: Inferring how to identify savings vs. investment plans from available flags.

---

## Assessment_Q2.sql — Transaction Frequency Analysis
- **Approach**: Grouped transaction counts per month per user, averaged them, then used `CASE` to categorize frequency.
- **Challenge**: Ensuring correct time truncation and rounding logic for category boundaries.

---

## Assessment_Q3.sql — Account Inactivity Alert
- **Approach**: Pulled latest transaction date per account, checked difference with `CURRENT_DATE`, flagged those with inactivity > 365 days.
- **Challenge**: Handling savings and investment account types with available flags.

---

## Assessment_Q4.sql — Customer Lifetime Value (CLV)
- **Approach**: Calculated tenure from signup date, total transactions from savings table, applied CLV formula using 0.1% profit per transaction value.
- **Challenge**: Handling possible division by zero and making results interpretable (in naira instead of kobo if needed).

---

## Notes
- Assumed PostgreSQL-style SQL.
- Used common conventions for CTEs and subqueries.
- All queries tested logically and written for clarity and performance.
