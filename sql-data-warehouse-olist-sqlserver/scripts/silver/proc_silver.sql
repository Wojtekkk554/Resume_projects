-- Data Cleaning and Transformation from Bronze to Silver - SQL Server Version
-- This script performs data cleansing, trimming, and deduplication.
USE OlistDW;
GO

-- 1. Populate cl_customers
TRUNCATE TABLE silver.cl_customers;
WITH DeDup AS (
    SELECT 
        TRIM(customer_id) as customer_id,
        TRIM(customer_unique_id) as customer_unique_id,
        TRIM(customer_zip_code_prefix) as customer_zip_code_prefix,
        TRIM(customer_city) as customer_city,
        TRIM(customer_state) as customer_state,
        ROW_NUMBER() OVER(PARTITION BY TRIM(customer_id) ORDER BY (SELECT NULL)) as rn
    FROM bronze.raw_customers
)
INSERT INTO silver.cl_customers
SELECT customer_id, customer_unique_id, customer_zip_code_prefix, customer_city, customer_state
FROM DeDup WHERE rn = 1;

-- 2. Populate cl_orders
TRUNCATE TABLE silver.cl_orders;
WITH DeDup AS (
    SELECT 
        TRIM(order_id) as order_id,
        TRIM(customer_id) as customer_id,
        TRIM(order_status) as order_status,
        order_purchase_timestamp,
        order_approved_at,
        order_delivered_carrier_date,
        order_delivered_customer_date,
        order_estimated_delivery_date,
        ROW_NUMBER() OVER(PARTITION BY TRIM(order_id) ORDER BY (SELECT NULL)) as rn
    FROM bronze.raw_orders
)
INSERT INTO silver.cl_orders
SELECT order_id, customer_id, order_status, order_purchase_timestamp, order_approved_at, 
       order_delivered_carrier_date, order_delivered_customer_date, order_estimated_delivery_date
FROM DeDup WHERE rn = 1;

-- 3. Populate cl_order_items
TRUNCATE TABLE silver.cl_order_items;
WITH DeDup AS (
    SELECT 
        TRIM(order_id) as order_id,
        order_item_id,
        TRIM(product_id) as product_id,
        TRIM(seller_id) as seller_id,
        shipping_limit_date,
        price,
        freight_value,
        ROW_NUMBER() OVER(PARTITION BY TRIM(order_id), order_item_id ORDER BY (SELECT NULL)) as rn
    FROM bronze.raw_order_items
)
INSERT INTO silver.cl_order_items
SELECT order_id, order_item_id, product_id, seller_id, shipping_limit_date, price, freight_value
FROM DeDup WHERE rn = 1;

-- 4. Populate cl_products
TRUNCATE TABLE silver.cl_products;
WITH DeDup AS (
    SELECT 
        TRIM(product_id) as product_id,
        TRIM(COALESCE(product_category_name, 'unknown')) as product_category_name,
        product_name_lenght,
        product_description_lenght,
        product_photos_qty,
        product_weight_g,
        product_length_cm,
        product_height_cm,
        product_width_cm,
        ROW_NUMBER() OVER(PARTITION BY TRIM(product_id) ORDER BY (SELECT NULL)) as rn
    FROM bronze.raw_products
)
INSERT INTO silver.cl_products
SELECT product_id, product_category_name, product_name_lenght, product_description_lenght, 
       product_photos_qty, product_weight_g, product_length_cm, product_height_cm, product_width_cm
FROM DeDup WHERE rn = 1;

-- 5. Populate cl_sellers
TRUNCATE TABLE silver.cl_sellers;
WITH DeDup AS (
    SELECT 
        TRIM(seller_id) as seller_id,
        TRIM(seller_zip_code_prefix) as seller_zip_code_prefix,
        TRIM(seller_city) as seller_city,
        TRIM(seller_state) as seller_state,
        ROW_NUMBER() OVER(PARTITION BY TRIM(seller_id) ORDER BY (SELECT NULL)) as rn
    FROM bronze.raw_sellers
)
INSERT INTO silver.cl_sellers
SELECT seller_id, seller_zip_code_prefix, seller_city, seller_state
FROM DeDup WHERE rn = 1;

-- 6. Populate cl_order_payments
TRUNCATE TABLE silver.cl_order_payments;
WITH DeDup AS (
    SELECT 
        TRIM(order_id) as order_id,
        payment_sequential,
        TRIM(payment_type) as payment_type,
        payment_installments,
        payment_value,
        ROW_NUMBER() OVER(PARTITION BY TRIM(order_id), payment_sequential ORDER BY (SELECT NULL)) as rn
    FROM bronze.raw_order_payments
)
INSERT INTO silver.cl_order_payments
SELECT order_id, payment_sequential, payment_type, payment_installments, payment_value
FROM DeDup WHERE rn = 1;

-- 7. Populate cl_order_reviews
TRUNCATE TABLE silver.cl_order_reviews;
WITH DeDup AS (
    SELECT 
        TRIM(review_id) as review_id,
        TRIM(order_id) as order_id,
        review_score,
        TRIM(review_comment_title) as review_comment_title,
        TRIM(review_comment_message) as review_comment_message,
        review_creation_date,
        review_answer_timestamp,
        ROW_NUMBER() OVER(PARTITION BY TRIM(review_id) ORDER BY (SELECT NULL)) as rn
    FROM bronze.raw_order_reviews
)
INSERT INTO silver.cl_order_reviews
SELECT review_id, order_id, review_score, review_comment_title, review_comment_message, 
       review_creation_date, review_answer_timestamp
FROM DeDup WHERE rn = 1;
GO
