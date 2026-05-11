# SQL Data Warehouse - Olist E-Commerce (SQL Server)

## Project Overview
This project implements a comprehensive **Data Warehouse** using **Microsoft SQL Server**, following the **Medallion Architecture**. It processes the Olist E-Commerce dataset from Brazil to provide business-ready analytical insights through a structured Star Schema.

## Key Features
- **Medallion Architecture**: Implementation of Bronze, Silver, and Gold layers for structured data management.
- **Advanced T-SQL Transformations**: Usage of Stored Procedures, CTEs, and Window Functions for data processing.
- **Dimensional Modeling**: Fully functional Star Schema with optimized Fact and Dimension tables for analytical performance.
- **Automated Pipeline**: End-to-end automation scripts for environment setup and data loading.
- **Data Integrity**: Integrated validation checks at every layer to ensure high data quality.

## Tech Stack
- **Database**: Microsoft SQL Server
- **ETL/ELT**: T-SQL (Stored Procedures)
- **Data Prep**: PowerShell
- **Modeling**: Star Schema (Kimball Methodology)
- **Tools**: SQL Server Management Studio (SSMS)

## Project Architecture
The data flows through three distinct layers:
1.  **Bronze (Raw)**: Raw ingestion of CSV data into the **bronze** schema using BULK INSERT.
2.  **Silver (Cleaned)**: Data cleaning, deduplication, and standardization (handling nulls, formatting dates) in the silver schema.
3.  **Gold (Analytical)**: Final business-level modeling into a Star Schema (gold schema) for reporting and BI.

![Data Architecture](docs/architecture/data_architecture.png)

## Repository Structure
- **analytics/**: Jupyter Notebook (`.ipynb`) containing visual business analysis and insights.
- **scripts/bronze/**: DDL and Load scripts for raw data.
- **scripts/silver/**: Cleansing logic and transformation procedures.
- **scripts/gold/**: Dimensional modeling (Star Schema).
- **datasets/**: Raw Olist data files.
- **docs/**: Technical documentation and architecture diagrams.
- **tests/**: Scripts for verifying data quality and referential integrity.

## Getting Started
1. Clone the repository.
2. Run `scripts/bronze/prepare_datasets.ps1` to prepare source files.
3. Execute `scripts/run_pipeline.sql` to build the entire warehouse from scratch.
4. Explore interactive analytical insights in `analytics/olist_insights.ipynb`.
5. Additional queries are available in `scripts/gold/analytics.sql`.

## Key Business Insights
- Revenue trends and seasonal growth.
- Most profitable product categories.
- Delivery performance analysis (Actual vs. Estimated).
- Customer geographic distribution.
