-- Data Quality Tests - SQL Server Version

-- 1. Check for Nulls in Primary Keys (Silver)
SELECT 'cl_customers PK check' AS test_name, COUNT(*) AS failed_records FROM silver.cl_customers WHERE customer_id IS NULL
UNION ALL
SELECT 'cl_orders PK check', COUNT(*) FROM silver.cl_orders WHERE order_id IS NULL;
GO

-- 2. Check for Referential Integrity (Gold)
-- Fact_sales should only have valid keys from dimensions
SELECT 
    'Fact_sales invalid customer key' AS test_name,
    COUNT(*) AS failed_records
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c ON f.key_customer = c.key_customer
WHERE c.key_customer IS NULL;
GO

-- 3. Check for Duplicate Orders (Gold)
SELECT
    'Duplicate fact_sales keys' AS test_name,
    COUNT(*) AS failed_records
FROM (
    SELECT key_sales, COUNT(1) as cnt
    FROM gold.fact_sales
    GROUP BY key_sales
    HAVING COUNT(1) > 1
) sub;
GO

-- 4. Check for Negative Prices
SELECT
    'Negative prices in fact_sales' AS test_name,
    COUNT(*) AS failed_records
FROM gold.fact_sales
WHERE price < 0;
GO
