-- DDL for Gold Layer (Star Schema) - SQL Server Version
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'gold')
BEGIN
    EXEC('CREATE SCHEMA gold')
END
GO

-- Dimension: Customers
DROP TABLE IF EXISTS gold.dim_customers;
SELECT
    LOWER(CONVERT(VARCHAR(32), HASHBYTES('MD5', CAST(customer_id AS VARCHAR(MAX))), 2)) AS key_customer,
    customer_id AS customer_business_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
INTO gold.dim_customers
FROM silver.cl_customers;

-- Dimension: Products
DROP TABLE IF EXISTS gold.dim_products;
SELECT
    LOWER(CONVERT(VARCHAR(32), HASHBYTES('MD5', CAST(product_id AS VARCHAR(MAX))), 2)) AS key_product,
    product_id AS product_business_id,
    product_category_name,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
INTO gold.dim_products
FROM silver.cl_products;

-- Dimension: Sellers
DROP TABLE IF EXISTS gold.dim_sellers;
SELECT
    LOWER(CONVERT(VARCHAR(32), HASHBYTES('MD5', CAST(seller_id AS VARCHAR(MAX))), 2)) AS key_seller,
    seller_id AS seller_business_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
INTO gold.dim_sellers
FROM silver.cl_sellers;

-- Dimension: Date (Simplified)
DROP TABLE IF EXISTS gold.dim_date;
SELECT DISTINCT
    CAST(FORMAT(order_purchase_timestamp, 'yyyyMMdd') AS INT) AS key_date,
    CAST(order_purchase_timestamp AS DATE) AS full_date,
    YEAR(order_purchase_timestamp) AS [year],
    MONTH(order_purchase_timestamp) AS [month],
    DAY(order_purchase_timestamp) AS [day],
    DATEPART(QUARTER, order_purchase_timestamp) AS [quarter],
    FORMAT(order_purchase_timestamp, 'MMMM') AS month_name,
    FORMAT(order_purchase_timestamp, 'dddd') AS day_name
INTO gold.dim_date
FROM silver.cl_orders;

-- Fact: Sales
DROP TABLE IF EXISTS gold.fact_sales;
SELECT
    LOWER(CONVERT(VARCHAR(32), HASHBYTES('MD5', CONCAT(CAST(i.order_id AS VARCHAR(MAX)), CAST(i.order_item_id AS VARCHAR(MAX)))), 2)) AS key_sales,
    LOWER(CONVERT(VARCHAR(32), HASHBYTES('MD5', CAST(o.customer_id AS VARCHAR(MAX))), 2)) AS key_customer,
    LOWER(CONVERT(VARCHAR(32), HASHBYTES('MD5', CAST(i.product_id AS VARCHAR(MAX))), 2)) AS key_product,
    LOWER(CONVERT(VARCHAR(32), HASHBYTES('MD5', CAST(i.seller_id AS VARCHAR(MAX))), 2)) AS key_seller,
    CAST(FORMAT(o.order_purchase_timestamp, 'yyyyMMdd') AS INT) AS key_date,
    o.order_id,
    i.order_item_id,
    i.price,
    i.freight_value,
    (i.price + i.freight_value) AS total_value,
    o.order_status
INTO gold.fact_sales
FROM silver.cl_orders o
JOIN silver.cl_order_items i ON o.order_id = i.order_id;
GO
