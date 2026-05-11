-- DDL for Bronze Layer (Raw Data) - SQL Server Version
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bronze')
BEGIN
    EXEC('CREATE SCHEMA bronze')
END
GO

DROP TABLE IF EXISTS bronze.raw_customers;
DROP TABLE IF EXISTS bronze.raw_orders;
DROP TABLE IF EXISTS bronze.raw_order_items;
DROP TABLE IF EXISTS bronze.raw_products;
DROP TABLE IF EXISTS bronze.raw_sellers;
DROP TABLE IF EXISTS bronze.raw_order_payments;
DROP TABLE IF EXISTS bronze.raw_order_reviews;
GO

CREATE TABLE bronze.raw_customers (
    customer_id VARCHAR(50),
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix VARCHAR(10),
    customer_city VARCHAR(100),
    customer_state VARCHAR(MAX) -- Increased to avoid truncation
);

CREATE TABLE bronze.raw_orders (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_status VARCHAR(50),
    order_purchase_timestamp DATETIME2,
    order_approved_at DATETIME2,
    order_delivered_carrier_date DATETIME2,
    order_delivered_customer_date DATETIME2,
    order_estimated_delivery_date DATETIME2
);

CREATE TABLE bronze.raw_order_items (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date DATETIME2,
    price DECIMAL(10, 2),
    freight_value DECIMAL(10, 2)
);

CREATE TABLE bronze.raw_products (
    product_id VARCHAR(50),
    product_category_name VARCHAR(100),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);

CREATE TABLE bronze.raw_sellers (
    seller_id VARCHAR(50),
    seller_zip_code_prefix VARCHAR(10),
    seller_city VARCHAR(100),
    seller_state VARCHAR(MAX) -- Increased to avoid truncation
);

CREATE TABLE bronze.raw_order_payments (
    order_id VARCHAR(50),
    payment_sequential INT,
    payment_type VARCHAR(50),
    payment_installments INT,
    payment_value DECIMAL(10, 2)
);

CREATE TABLE bronze.raw_order_reviews (
    review_id VARCHAR(50),
    order_id VARCHAR(50),
    review_score INT,
    review_comment_title VARCHAR(MAX), -- Increased to avoid truncation
    review_comment_message VARCHAR(MAX), -- Increased to avoid truncation
    review_creation_date DATETIME2,
    review_answer_timestamp DATETIME2
);
GO
