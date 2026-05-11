# Project Requirements

## Business Goals
1.  **Centralize E-Commerce Data**: Consolidate multiple CSV files into a single reliable source of truth.
2.  **Monitor Sales Performance**: Enable monthly and yearly revenue tracking.
3.  **Customer Insights**: Identify geographic distribution of customers and their buying behavior.
4.  **Product Quality**: Analyze review scores to identify top-performing product categories.

## Technical Requirements
1.  **Database**: Microsoft SQL Server must be used for storage and transformation.
2.  **Medallion Architecture**: Data must flow through Bronze (Raw), Silver (Clean), and Gold (Star Schema) layers.
3.  **Data Quality**: Implement tests to ensure primary key integrity and valid relationships.
4.  **Performance**: Gold layer must be optimized for analytical queries (Dimensions & Facts).
5.  **Documentation**: Provide full documentation including data catalog and naming conventions.

