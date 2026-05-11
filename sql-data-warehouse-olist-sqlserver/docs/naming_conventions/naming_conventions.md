# Naming Conventions

## Tables
- **Bronze Layer**: Prefixed with `raw_` (e.g., `bronze.raw_orders`).
- **Silver Layer**: Prefixed with `cl_` for cleaned tables (e.g., `silver.cl_orders`).
- **Gold Layer**: 
    - Fact tables: Prefixed with `fact_` (e.g., `gold.fact_sales`).
    - Dimension tables: Prefixed with `dim_` (e.g., `gold.dim_products`).

## Columns
- Use `snake_case` for all column names.
- Boolean columns should start with `is_` or `has_`.
- Date columns should end with `_date`.
- Timestamp columns should end with `_at`.
- Primary keys: `table_name_id` or a meaningful unique identifier.
- Surrogate keys in Gold layer: `key_` prefix (e.g., `key_product`).

## Schemas
- `bronze`: Landing zone for raw data.
- `silver`: Cleaned and standardized data.
- `gold`: Curated data for analytics.
