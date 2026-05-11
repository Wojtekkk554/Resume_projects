# Data Catalog - Olist E-Commerce

## Staging / Bronze Layer Tables
This layer contains raw data ingested directly from the CSV sources.

### 1. `bronze.raw_customers`
- **Source:** `olist_customers_dataset.csv`
- **Primary Key:** `customer_id`
- **Columns:**
  - `customer_id`: Unique identifier for each customer/order session.
  - `customer_unique_id`: Persistent identifier for the customer across multiple orders.
  - `customer_zip_code_prefix`: Customer's postal code prefix.
  - `customer_city`: City of the customer.
  - `customer_state`: State of the customer.

### 2. `bronze.raw_orders`
- **Source:** `olist_orders_dataset.csv`
- **Primary Key:** `order_id`
- **Columns:**
  - `order_id`: Unique identifier for the order.
  - `customer_id`: Link to customers table.
  - `order_status`: Status of the order (delivered, canceled, etc.).
  - `order_purchase_timestamp`: Date and time of purchase.
  - `order_approved_at`: Payment approval time.
  - `order_delivered_carrier_date`: When it left the seller.
  - `order_delivered_customer_date`: Actual arrival date.
  - `order_estimated_delivery_date`: Expected arrival date.

### 3. `bronze.raw_order_items`
- **Source:** `olist_order_items_dataset.csv`
- **Primary Key:** Composite (`order_id`, `order_item_id`)
- **Columns:**
  - `order_id`: Link to orders table.
  - `order_item_id`: Item number within an order.
  - `product_id`: Link to products table.
  - `seller_id`: Link to sellers table.
  - `shipping_limit_date`: Seller's deadline to ship.
  - `price`: Item price.
  - `freight_value`: Shipping cost for the item.

### 4. `bronze.raw_products`
- **Source:** `olist_products_dataset.csv`
- **Primary Key:** `product_id`
- **Columns:**
  - `product_id`: Unique product ID.
  - `product_category_name`: Name of the category.
  - `product_weight_g`: Weight in grams.
  - `product_length_cm`, `product_height_cm`, `product_width_cm`: Dimensions.

### 5. `bronze.raw_sellers`
- **Source:** `olist_sellers_dataset.csv`
- **Primary Key:** `seller_id`
- **Columns:**
  - `seller_id`: Unique seller ID.
  - `seller_zip_code_prefix`, `seller_city`, `seller_state`: Seller location.

### 6. `bronze.raw_order_payments`
- **Source:** `olist_order_payments_dataset.csv`
- **Columns:**
  - `order_id`: Link to orders.
  - `payment_sequential`: Payment sequence number.
  - `payment_type`: Method (credit card, boleto, etc.).
  - `payment_installments`: Number of installments.
  - `payment_value`: Amount paid.

### 7. `bronze.raw_order_reviews`
- **Source:** `olist_order_reviews_dataset.csv`
- **Columns:**
  - `review_id`: Unique review ID.
  - `order_id`: Link to order.
  - `review_score`: 1 to 5 stars.
  - `review_comment_title`, `review_comment_message`: Text feedback.
  - `review_creation_date`, `review_answer_timestamp`: Timestamps.

## Core / Gold Layer Tables (Star Schema)
Optimized for high-performance analytics.

### 1. `gold.fact_sales`
- **Grain:** One row per order item.
- **Keys:** `key_sales` (PK), `key_customer` (FK), `key_product` (FK), `key_seller` (FK), `key_date` (FK).
- **Measures:** `price`, `freight_value`, `total_value`.

### 2. `gold.dim_customers`
- **Attributes:** City, State, Unique ID.

### 3. `gold.dim_products`
- **Attributes:** Category, Dimensions, Weight.

### 4. `gold.dim_sellers`
- **Attributes:** City, State.

### 5. `gold.dim_date`
- **Attributes:** Year, Month, Day, Quarter, Month Name, Day Name.
