-- DDL for Silver Layer (Cleaned Data) - SQL Server Version
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'silver')
BEGIN
    EXEC('CREATE SCHEMA silver')
END
GO

DROP TABLE IF EXISTS silver.cl_customers;
DROP TABLE IF EXISTS silver.cl_orders;
DROP TABLE IF EXISTS silver.cl_order_items;
DROP TABLE IF EXISTS silver.cl_products;
DROP TABLE IF EXISTS silver.cl_sellers;
DROP TABLE IF EXISTS silver.cl_order_payments;
DROP TABLE IF EXISTS silver.cl_order_reviews;
GO

CREATE TABLE silver.cl_customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix VARCHAR(10),
    customer_city VARCHAR(100),
    customer_state VARCHAR(10)
);

CREATE TABLE silver.cl_orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_status VARCHAR(50),
    order_purchase_timestamp DATETIME2,
    order_approved_at DATETIME2,
    order_delivered_carrier_date DATETIME2,
    order_delivered_customer_date DATETIME2,
    order_estimated_delivery_date DATETIME2
);

CREATE TABLE silver.cl_order_items (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date DATETIME2,
    price DECIMAL(10, 2),
    freight_value DECIMAL(10, 2),
    PRIMARY KEY (order_id, order_item_id)
);

CREATE TABLE silver.cl_products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);

CREATE TABLE silver.cl_sellers (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix VARCHAR(10),
    seller_city VARCHAR(100),
    seller_state VARCHAR(10)
);

CREATE TABLE silver.cl_order_payments (
    order_id VARCHAR(50),
    payment_sequential INT,
    payment_type VARCHAR(50),
    payment_installments INT,
    payment_value DECIMAL(10, 2),
    PRIMARY KEY (order_id, payment_sequential)
);

CREATE TABLE silver.cl_order_reviews (
    review_id VARCHAR(50),
    order_id VARCHAR(50),
    review_score INT,
    review_comment_title VARCHAR(MAX),
    review_comment_message VARCHAR(MAX),
    review_creation_date DATETIME2,
    review_answer_timestamp DATETIME2,
    PRIMARY KEY (review_id)
);
GO
