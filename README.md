# Supply Chain Shipment & Delivery SLA Analytics

## 📌 Project Overview

This project analyzes **supply chain shipment and delivery performance** for a global logistics company using **MySQL and SQL**.

The company manages customers, products, warehouses, orders, shipment carriers, delivery tracking, and product returns. The objective of this project is to transform operational data into actionable insights around:

* Order performance
* Customer purchasing behavior
* Shipment performance
* Delivery delays
* SLA compliance
* Carrier performance
* Warehouse efficiency
* Product return rates
* Monthly logistics trends

The project contains **25 SQL tasks** covering database design, data insertion, joins, aggregations, subqueries, CTEs, window functions, views, and indexing.

---

## 🎯 Business Objectives

The analysis focuses on answering questions such as:

1. Which customers generate the highest order value?
2. Which customers have never placed an order?
3. How many shipments are handled by each carrier?
4. Which shipments were delivered late?
5. Which shipments breached their SLA?
6. Which carriers have the highest SLA compliance?
7. Which carriers perform best/worst based on delivery performance?
8. Which carriers rank highest within each region?
9. Which warehouses have the longest average delivery time?
10. Which warehouses have the highest number of delayed shipments?
11. How do shipment and SLA metrics change month by month?
12. Which region has the highest SLA breach percentage?
13. Which products have the highest return rate?
14. Which high-value customers have experienced product returns?

---

# 🏗️ Database Architecture

The project uses a relational database consisting of **9 tables**.

   text
                         ┌──────────────┐
                         │  Customers   │
                         └──────┬───────┘
                                │
                                │ Customer_ID
                                ▼
                         ┌──────────────┐
                         │    Orders    │
                         └──────┬───────┘
                                │
                     ┌──────────┴──────────┐
                     │                     │
                     ▼                     ▼
              ┌──────────────┐      ┌───────────────┐
              │Order_Details │      │   Shipments   │
              └──────┬───────┘      └───────┬───────┘
                     │                      │
                     ▼                      ├───────────────┐
              ┌──────────────┐              │               │
              │   Products   │              ▼               ▼
              └──────────────┘      ┌──────────────┐ ┌──────────────┐
                                    │   Carriers   │ │Delivery_     │
                                    │              │ │Tracking      │
                                    └──────────────┘ └──────────────┘

              ┌──────────────┐
              │  Warehouses  │
              └──────┬───────┘
                     │
                     │ Warehouse_ID
                     ▼
                  Orders

              ┌──────────────┐
              │   Returns    │
              └──────┬───────┘
                     │
                     ├── Order_ID
                     └── Product_ID
   

---

# 🗄️ Database Schema

## 1. Customers

Stores customer master information.

| Column        | Description            |
| ------------- | ---------------------- |
| Customer_ID   | Primary key            |
| Customer_Name | Customer name          |
| Email         | Unique email address   |
| Phone         | Customer phone number  |
| Region        | Customer region        |
| City          | Customer city          |
| Created_Date  | Customer creation date |

---

## 2. Products

Stores product and pricing information.

| Column       | Description                     |
| ------------ | ------------------------------- |
| Product_ID   | Primary key                     |
| Product_Name | Product name                    |
| Category     | Product category                |
| Unit_Price   | Product price                   |
| Weight_KG    | Product weight                  |
| Returnable   | Whether product can be returned |

---

## 3. Warehouses

Stores warehouse information.

| Column         | Description        |
| -------------- | ------------------ |
| Warehouse_ID   | Primary key        |
| Warehouse_Name | Warehouse name     |
| Region         | Warehouse region   |
| City           | Warehouse city     |
| Capacity       | Warehouse capacity |

---

## 4. Orders

Stores customer order information.

| Column       | Description              |
| ------------ | ------------------------ |
| Order_ID     | Primary key              |
| Customer_ID  | Foreign key → Customers  |
| Warehouse_ID | Foreign key → Warehouses |
| Order_Date   | Date of order            |
| Order_Status | Current order status     |
| Order_Value  | Total order value        |

---

## 5. Order_Details

Stores products contained within each order.

| Column          | Description            |
| --------------- | ---------------------- |
| Order_Detail_ID | Primary key            |
| Order_ID        | Foreign key → Orders   |
| Product_ID      | Foreign key → Products |
| Quantity        | Quantity ordered       |
| Unit_Price      | Price at time of order |

---

## 6. Carriers

Stores shipment carrier information.

| Column         | Description           |
| -------------- | --------------------- |
| Carrier_ID     | Primary key           |
| Carrier_Name   | Carrier name          |
| Region         | Carrier region        |
| Contact_Number | Carrier contact       |
| SLA_Days       | Expected delivery SLA |

---

## 7. Shipments

Stores shipment and delivery information.

| Column            | Description            |
| ----------------- | ---------------------- |
| Shipment_ID       | Primary key            |
| Order_ID          | Foreign key → Orders   |
| Carrier_ID        | Foreign key → Carriers |
| Shipment_Date     | Shipment date          |
| Expected_Delivery | Expected delivery date |
| Actual_Delivery   | Actual delivery date   |
| Shipment_Status   | Shipment status        |

---

## 8. Delivery_Tracking

Stores shipment tracking events.

| Column          | Description             |
| --------------- | ----------------------- |
| Tracking_ID     | Primary key             |
| Shipment_ID     | Foreign key → Shipments |
| Tracking_Date   | Tracking timestamp      |
| Location        | Shipment location       |
| Tracking_Status | Current tracking status |

---

## 9. Returns

Stores returned products.

| Column          | Description            |
| --------------- | ---------------------- |
| Return_ID       | Primary key            |
| Order_ID        | Foreign key → Orders   |
| Product_ID      | Foreign key → Products |
| Return_Date     | Return date            |
| Return_Quantity | Quantity returned      |
| Return_Reason   | Reason for return      |

---

# 🛠️ Tech Stack

* **Database:** MySQL 8+
* **Language:** SQL
* **IDE:** MySQL Workbench
* **Version Control:** Git & GitHub

### SQL Techniques Used

*  CREATE DATABASE 
*  CREATE TABLE 
* Primary Keys
* Foreign Keys
*  NOT NULL 
*  UNIQUE 
*  CHECK 
*  DEFAULT 
*  INSERT 
*  INNER JOIN 
*  LEFT JOIN 
*  GROUP BY 
*  HAVING 
*  ORDER BY 
*  LIMIT 
* Aggregate Functions
*  CASE 
* Date Functions
* Subqueries
* Common Table Expressions (CTEs)
* Window Functions
*  RANK() 
*  DENSE_RANK() 
* Views
* Indexes

---

# 📁 Repository Structure

   text
supply-chain-shipment-sla-analytics/
│
├── README.md
│
├── sql/
│   ├── 01_create_database.sql
│   ├── 02_create_tables.sql
│   ├── 03_insert_sample_data.sql
│   ├── 04_tasks_03_to_25.sql
│   └── 05_validation_queries.sql
│
└── docs/
    └── project_screenshots/
   

---

# ⚙️ Setup Instructions

## Prerequisites

Install:

* MySQL Server 8+
* MySQL Workbench
* Git

---

## Step 1 — Clone the Repository

   bash
git clone https://github.com/<your-username>/supply-chain-shipment-sla-analytics.git
   

Navigate into the project:

   bash
cd supply-chain-shipment-sla-analytics
   

---

# ▶️ Execution Order

Run the SQL scripts in the following order.

## Step 1 — Create Database

Execute:

   text
sql/01_create_database.sql
   

This creates:

   text
supply_chain_db
   

---

## Step 2 — Create Tables

Execute:

   text
sql/02_create_tables.sql
   

This creates the 9 relational tables:

   text
Customers
Products
Warehouses
Orders
Order_Details
Carriers
Shipments
Delivery_Tracking
Returns
   

---

## Step 3 — Insert Sample Data

Execute:

   text
sql/03_insert_sample_data.sql
   

Recommended insertion order:

   text
Customers
   ↓
Products
   ↓
Warehouses
   ↓
Carriers
   ↓
Orders
   ↓
Order_Details
   ↓
Shipments
   ↓
Delivery_Tracking
   ↓
Returns
   

The order is important because of the foreign-key relationships.

---

## Step 4 — Execute Analytical Queries

Execute:

   text
sql/04_tasks_03_to_25.sql
   

This file contains the SQL solutions for Tasks 3–25.

Each task is clearly separated using comments:

   sql
-- =====================================================
-- TASK 3
-- =====================================================

-- Query


-- =====================================================
-- TASK 4
-- =====================================================

-- Query
   

---

## Step 5 — Run Validation Queries

Execute:

   text
sql/05_validation_queries.sql
   

These queries verify record counts, data consistency, relationships, and analytical calculations.

---

# 🧪 Data Validation

Data validation is performed before analyzing the dataset.

## Validate Record Counts

   sql
SELECT 'Customers' AS Table_Name, COUNT(*) AS Record_Count
FROM Customers

UNION ALL

SELECT 'Products', COUNT(*)
FROM Products

UNION ALL

SELECT 'Warehouses', COUNT(*)
FROM Warehouses

UNION ALL

SELECT 'Orders', COUNT(*)
FROM Orders

UNION ALL

SELECT 'Order_Details', COUNT(*)
FROM Order_Details

UNION ALL

SELECT 'Carriers', COUNT(*)
FROM Carriers

UNION ALL

SELECT 'Shipments', COUNT(*)
FROM Shipments

UNION ALL

SELECT 'Delivery_Tracking', COUNT(*)
FROM Delivery_Tracking

UNION ALL

SELECT 'Returns', COUNT(*)
FROM Returns;
   

Expected base dataset:

   text
Customers          15
Products           10
Warehouses          8
Orders             40
Order_Details      50
Carriers            8
Shipments          40
Delivery_Tracking 112
Returns            16
   

---

# 🔍 Validate Order Values

 Orders.Order_Value  should match the calculated value from  Order_Details .

   sql
SELECT
    o.Order_ID,
    o.Order_Value,
    SUM(od.Quantity * od.Unit_Price) AS Calculated_Value
FROM Orders o
JOIN Order_Details od
    ON o.Order_ID = od.Order_ID
GROUP BY
    o.Order_ID,
    o.Order_Value
HAVING o.Order_Value <> SUM(od.Quantity * od.Unit_Price);
   

### Expected Result

   text
Empty Set
   

An empty result means all stored order values match the calculated order-detail totals.

---

# 🔗 Validate Foreign-Key Relationships

## Orders without valid customers

   sql
SELECT o.Order_ID
FROM Orders o
LEFT JOIN Customers c
    ON o.Customer_ID = c.Customer_ID
WHERE c.Customer_ID IS NULL;
   

Expected:

   text
Empty Set
   

## Orders without valid warehouses

   sql
SELECT o.Order_ID
FROM Orders o
LEFT JOIN Warehouses w
    ON o.Warehouse_ID = w.Warehouse_ID
WHERE w.Warehouse_ID IS NULL;
   

Expected:

   text
Empty Set
   

## Shipments without valid orders

   sql
SELECT s.Shipment_ID
FROM Shipments s
LEFT JOIN Orders o
    ON s.Order_ID = o.Order_ID
WHERE o.Order_ID IS NULL;
   

Expected:

   text
Empty Set
   

---

# 📊 Analytical Tasks

The project contains 25 SQL tasks.

| Task | Analysis                                           |
| ---: | -------------------------------------------------- |
|    1 | Create database tables with constraints            |
|    2 | Insert realistic sample data                       |
|    3 | Display orders with customer and warehouse details |
|    4 | Top 10 customers by total order value              |
|    5 | Customers with no orders                           |
|    6 | Number of shipments by carrier                     |
|    7 | Shipments delivered after expected date            |
|    8 | Delivery days for completed shipments              |
|    9 | SLA status classification                          |
|   10 | SLA compliance percentage by carrier               |
|   11 | Best/worst carrier performance                     |
|   12 | Top 3 carriers by region using window functions    |
|   13 | Average delivery time by warehouse                 |
|   14 | Warehouses with highest delayed shipments          |
|   15 | Monthly shipment and SLA performance               |
|   16 | Region with highest SLA breach percentage          |
|   17 | Products with highest return rate                  |
|   18 | High-frequency customers with returned products    |
|   19 | Shipments with multiple tracking updates           |
|   20 | Late high-value orders                             |
|   21 | Warehouse ranking using  RANK()  /  DENSE_RANK()   |
|   22 | Second-highest carrier by SLA compliance           |
|   23 | Customers spending above average using CTE         |
|   24 | Shipment performance view                          |
|   25 | Performance indexes                                |

---

# 🧠 SQL Concepts Demonstrated

## 1. Multi-table JOINs

Example:

   sql
FROM Orders o
JOIN Customers c
    ON o.Customer_ID = c.Customer_ID
JOIN Warehouses w
    ON o.Warehouse_ID = w.Warehouse_ID
   

Used to combine operational data from multiple tables.

---

## 2. LEFT JOIN

Used to identify customers who have no orders.

   sql
FROM Customers c
LEFT JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
WHERE o.Order_ID IS NULL;
   

---

## 3. Aggregations

Functions used throughout the project include:

   text
COUNT()
SUM()
AVG()
MAX()
MIN()
   

---

## 4. GROUP BY

Used to calculate metrics at different business levels:

   text
Customer
Carrier
Warehouse
Region
Month
Product
   

---

## 5. CASE Expressions

Used for SLA classification:

   sql
CASE
    WHEN Actual_Delivery <= Expected_Delivery
        THEN 'ON TIME'
    ELSE 'SLA BREACHED'
END
   

---

## 6. Subqueries

Used for comparisons such as:

   text
Orders above average order value
Customers above average spending
Second-highest carrier performance
   

---

## 7. Common Table Expressions

CTEs are used to break complex analytical logic into readable steps.

Example pattern:

   sql
WITH customer_spending AS (
    SELECT
        Customer_ID,
        SUM(Order_Value) AS Total_Spending
    FROM Orders
    GROUP BY Customer_ID
)
SELECT *
FROM customer_spending;
   

---

## 8. Window Functions

The project uses window functions for ranking and partitioned analysis.

Examples:

   text
RANK()
DENSE_RANK()
ROW_NUMBER()
   

These are particularly useful for carrier and warehouse performance analysis.

---

## 9. Views

The project creates:

   text
Shipment_Performance_View
   

The view combines:

   text
Order
Customer
Warehouse
Carrier
Shipment
Delivery Performance
SLA Status
   

This provides a reusable analytical dataset.

---

## 10. Indexing

Indexes are created to improve query performance on frequently used columns such as:

   text
Customer_ID
Order_ID
Shipment_ID
Carrier_ID
Shipment_Date
   

---

# 📈 Business Insights

The SQL analysis is designed to provide the following business insights.

## Customer Performance

Customer-level order aggregation identifies the highest-value customers and customers with no order activity.

This can help the business understand:

* High-value customer segments
* Customer purchasing concentration
* Inactive customers
* Opportunities for customer retention

---

## Carrier Performance

Shipment and SLA analysis compares carriers based on:

* Shipment volume
* Delivery time
* Delayed shipments
* SLA compliance
* Regional performance

This allows management to identify carriers that require closer operational monitoring.

---

## SLA Performance

Comparing:

   text
Actual_Delivery
        vs
Expected_Delivery
   

allows shipments to be classified as:

   text
ON TIME
SLA BREACHED
   

The resulting SLA compliance percentage provides a measurable view of delivery reliability.

---

## Warehouse Efficiency

Warehouse-level analysis measures:

* Average delivery time
* Number of delayed shipments
* Delivery performance ranking

This can help identify warehouses that may require operational investigation.

---

## Product Returns

Product-level return analysis identifies products with relatively high return activity.

Potential areas for investigation include:

* Product quality
* Product category
* Order fulfillment accuracy
* Customer expectations
* Return reasons

---

## High-Value Late Orders

Combining:

   text
Order Value
+
Delivery Performance
   

helps identify late shipments that have greater potential business impact.

A late low-value shipment and a late high-value shipment do not necessarily carry the same operational significance.

---

## Monthly Trends

Monthly analysis tracks:

* Total orders
* Total shipments
* Delivered shipments
* Delayed shipments
* SLA compliance

This provides visibility into changes in logistics performance over time.

---

# ⚠️ Dataset Notes

The project uses a realistic sample dataset created specifically for SQL analysis and demonstration purposes.

The current sample contains:

* 15 customers
* 10 products
* 8 warehouses
* 8 carriers
* 40 orders
* 50 order-detail records
* 40 shipments
* 112 tracking records
* 16 return records


# 🚀 Key Learning Outcomes

Through this project, I practiced:

* Designing a relational database
* Creating tables with constraints
* Managing primary and foreign keys
* Loading relational sample data
* Writing multi-table SQL joins
* Performing business aggregations
* Working with dates
* Calculating delivery metrics
* Building SLA logic
* Using subqueries
* Writing CTEs
* Applying window functions
* Creating reusable SQL views
* Creating indexes
* Performing data validation
* Translating business requirements into SQL

---

# 💼 Data Engineering Relevance

This project demonstrates practical SQL skills relevant to Data Engineering roles, particularly around:

   text
Data Modeling
      ↓
Data Ingestion
      ↓
Data Validation
      ↓
Transformation
      ↓
Analytical SQL
      ↓
Performance Optimization
      ↓
Business Reporting
   

The project provides hands-on experience with relational data and analytical transformations that are commonly used as building blocks within larger data pipelines and cloud data platforms.

---

# 📌 Future Enhancements

Potential extensions include:

* Build an ETL pipeline using Python
* Load the data into Azure SQL Database
* Build an Azure Data Factory pipeline
* Store raw data in Azure Data Lake Storage
* Process data using Databricks / PySpark
* Build a Power BI shipment-performance dashboard
* Add automated data-quality checks
* Add incremental data loading
* Add CI/CD using GitHub Actions
* Add query-performance benchmarking
* Add additional carriers to support richer regional ranking analysis

---

# 👨‍💻 Author

**Subanandham E R**

Data Engineering | SQL | Python | PySpark | Azure | AWS

This project was developed as part of my hands-on Data Engineering portfolio to demonstrate practical SQL, relational data modeling, data validation, and business analytics skills.

---

# ⭐ Project Highlights

   text
9     Relational Tables
25    SQL Tasks
40    Orders
40    Shipments
112   Tracking Events
16    Return Records

JOINs
CTEs
Subqueries
Window Functions
Views
Indexes
Data Validation
SLA Analytics
   

---

## 📄 License

This project is intended for educational and portfolio purposes.

