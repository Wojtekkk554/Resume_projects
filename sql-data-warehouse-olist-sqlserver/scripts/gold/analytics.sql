USE OlistDW;
GO

-- Analytical Queries for Business Insights - SQL Server Version

-- 1. Monthly Revenue Trend
SELECT
    d.year,
    d.month,
    d.month_name,
    SUM(f.total_value) AS monthly_revenue,
    COUNT(DISTINCT f.order_id) AS total_orders
FROM gold.fact_sales f
JOIN gold.dim_date d ON f.key_date = d.key_date
GROUP BY d.year, d.month, d.month_name
ORDER BY d.year, d.month;

-- 2. Top 10 Product Categories by Revenue
SELECT TOP 10
    p.product_category_name,
    SUM(f.price) AS total_sales_revenue,
    COUNT(f.key_sales) AS items_sold
FROM gold.fact_sales f
JOIN gold.dim_products p ON f.key_product = p.key_product
GROUP BY p.product_category_name
ORDER BY total_sales_revenue DESC;

-- 3. Sales by Customer State
SELECT
    c.customer_state,
    SUM(f.total_value) AS revenue,
    COUNT(DISTINCT f.key_customer) AS customer_count
FROM gold.fact_sales f
JOIN gold.dim_customers c ON f.key_customer = c.key_customer
GROUP BY c.customer_state
ORDER BY revenue DESC;

-- 4. Average Review Score by Product Category
SELECT TOP 10
    p.product_category_name,
    AVG(CAST(r.review_score AS FLOAT)) AS avg_score,
    COUNT(r.review_id) AS review_count
FROM gold.fact_sales f
JOIN gold.dim_products p ON f.key_product = p.key_product
JOIN silver.cl_order_reviews r ON f.order_id = r.order_id
GROUP BY p.product_category_name
HAVING COUNT(r.review_id) > 100
ORDER BY avg_score DESC;
GO

