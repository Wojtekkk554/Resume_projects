/* 
   DOWÓD PROCESU £ADOWANIA (ETL) - WARSTWA BRONZE
   Metoda: Bulk Insert (TSV)
   Data: 2026-05-08
*/
USE OlistDW;
GO

-- 1. Klienci
TRUNCATE TABLE bronze.raw_customers;
BULK INSERT bronze.raw_customers
FROM 'C:\sql-data-warehouse-olist-sqlserver\datasets\olist_customers_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = '\t', 
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

-- 2. Zamówienia
TRUNCATE TABLE bronze.raw_orders;
BULK INSERT bronze.raw_orders
FROM 'C:\sql-data-warehouse-olist-sqlserver\datasets\olist_orders_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

-- 3. Przedmioty
TRUNCATE TABLE bronze.raw_order_items;
BULK INSERT bronze.raw_order_items
FROM 'C:\sql-data-warehouse-olist-sqlserver\datasets\olist_order_items_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

-- 4. Produkty
TRUNCATE TABLE bronze.raw_products;
BULK INSERT bronze.raw_products
FROM 'C:\sql-data-warehouse-olist-sqlserver\datasets\olist_products_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

-- 5. Sprzedawcy
TRUNCATE TABLE bronze.raw_sellers;
BULK INSERT bronze.raw_sellers
FROM 'C:\sql-data-warehouse-olist-sqlserver\datasets\olist_sellers_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

-- 6. P³atnoœci
TRUNCATE TABLE bronze.raw_order_payments;
BULK INSERT bronze.raw_order_payments
FROM 'C:\sql-data-warehouse-olist-sqlserver\datasets\olist_order_payments_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

-- 7. Recenzje (Dopuszczamy drobne b³êdy w komentarzach)
TRUNCATE TABLE bronze.raw_order_reviews;
BULK INSERT bronze.raw_order_reviews
FROM 'C:\sql-data-warehouse-olist-sqlserver\datasets\olist_order_reviews_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    MAXERRORS = 100,
    TABLOCK
);
GO

-- WERYFIKACJA ZA£ADOWANYCH DANYCH
SELECT 'Klienci' as Tabela, COUNT(*) as Ilosc FROM bronze.raw_customers UNION ALL
SELECT 'Zamówienia', COUNT(*) FROM bronze.raw_orders UNION ALL
SELECT 'Przedmioty', COUNT(*) FROM bronze.raw_order_items UNION ALL
SELECT 'Produkty', COUNT(*) FROM bronze.raw_products UNION ALL
SELECT 'Sprzedawcy', COUNT(*) FROM bronze.raw_sellers UNION ALL
SELECT 'P³atnoœci', COUNT(*) FROM bronze.raw_order_payments UNION ALL
SELECT 'Recenzje', COUNT(*) FROM bronze.raw_order_reviews;
