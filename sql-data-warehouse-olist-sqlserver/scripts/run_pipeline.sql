/*
===============================================================================
Master ETL Script: Full Data Warehouse Pipeline
===============================================================================
Purpose:
    This script orchestrates the entire ETL process:
    1. Infrastructure: Creates schemas and tables (DDL).
    2. Ingestion: Loads raw data into Bronze.
    3. Cleansing: Transforms data into Silver.
    4. Modeling: Builds the Gold Star Schema.
    5. Validation: Runs Data Quality tests.

Usage:
    - Open in SSMS and enable SQLCMD Mode (Query -> SQLCMD Mode).
===============================================================================
*/

USE OlistDW;
GO

PRINT '================================================';
PRINT 'Starting Full ETL Pipeline...';
PRINT '================================================';

-- 1. BRONZE LAYER
PRINT '>>> 1/5: Initializing Bronze Layer (DDL & Load)...';
:r "C:\sql-data-warehouse-olist-sqlserver\scripts\bronze\ddl_bronze.sql"
:r "C:\sql-data-warehouse-olist-sqlserver\scripts\bronze\load_bronze.sql"

-- 2. SILVER LAYER
PRINT '>>> 2/5: Initializing Silver Layer (DDL & Transformation)...';
:r "C:\sql-data-warehouse-olist-sqlserver\scripts\silver\ddl_silver.sql"
:r "C:\sql-data-warehouse-olist-sqlserver\scripts\silver\proc_silver.sql"

-- 3. GOLD LAYER
PRINT '>>> 3/5: Initializing Gold Layer (Star Schema Modeling)...';
-- Note: ddl_gold.sql in this project uses SELECT INTO, which creates tables on the fly.
:r "C:\sql-data-warehouse-olist-sqlserver\scripts\gold\ddl_gold.sql"

-- 4. DATA QUALITY TESTING
PRINT '>>> 4/5: Running Data Quality Tests...';
:r "C:\sql-data-warehouse-olist-sqlserver\tests\data_quality_tests.sql"

-- 5. ANALYTICS PREVIEW
PRINT '>>> 5/5: Generating Analytics Preview...';
:r "C:\sql-data-warehouse-olist-sqlserver\scripts\gold\analytics.sql"

PRINT '================================================';
PRINT 'ETL Pipeline Finished Successfully!';
PRINT '================================================';
GO
