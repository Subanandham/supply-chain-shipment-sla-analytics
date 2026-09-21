USE supply_chain_db;


-- ============================================================
-- VALIDATION QUERIES
-- Supply Chain Shipment & Delivery SLA Analytics
-- ============================================================


-- ============================================================
-- 1. CHECK DATABASE
-- ============================================================

SELECT DATABASE() AS Current_Database;


-- ============================================================
-- 2. CHECK ALL TABLES
-- ============================================================

SHOW TABLES;


-- ============================================================
-- 3. CHECK RECORD COUNTS
-- Expected:
-- Customers         = 15
-- Products          = 10
-- Warehouses        = 8
-- Orders            = 40
-- Order_Details     = 50
-- Carriers          = 12
-- Shipments         = 40
-- Delivery_Tracking = 112
-- Returns           = 16
-- ============================================================

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


-- ============================================================
-- 4. CHECK CUSTOMERS
-- ============================================================

SELECT *
FROM Customers
ORDER BY Customer_ID;


-- ============================================================
-- 5. CHECK PRODUCTS
-- ============================================================

SELECT *
FROM Products
ORDER BY Product_ID;


-- ============================================================
-- 6. CHECK WAREHOUSES
-- ============================================================

SELECT *
FROM Warehouses
ORDER BY Warehouse_ID;


-- ============================================================
-- 7. CHECK CARRIERS
-- ============================================================

SELECT
    Carrier_ID,
    Carrier_Name,
    Region,
    Contact_Number,
    SLA_Days
FROM Carriers
ORDER BY Carrier_ID;


-- ============================================================
-- 8. CHECK CARRIER DISTRIBUTION BY REGION
-- Expected: 3 carriers in each region
-- ============================================================

SELECT
    Region,
    COUNT(*) AS Carrier_Count
FROM Carriers
GROUP BY Region
ORDER BY Region;


-- ============================================================
-- 9. CHECK ORDERS
-- ============================================================

SELECT *
FROM Orders
ORDER BY Order_ID;


-- ============================================================
-- 10. CHECK ORDER DETAILS
-- ============================================================

SELECT *
FROM Order_Details
ORDER BY Order_Detail_ID;


-- ============================================================
-- 11. CHECK SHIPMENTS
-- ============================================================

SELECT *
FROM Shipments
ORDER BY Shipment_ID;


-- ============================================================
-- 12. CHECK DELIVERY TRACKING
-- ============================================================

SELECT *
FROM Delivery_Tracking
ORDER BY Tracking_ID;


-- ============================================================
-- 13. CHECK RETURNS
-- ============================================================

SELECT *
FROM Returns
ORDER BY Return_ID;


-- ============================================================
-- 14. VALIDATE ORDER VALUE
--
-- Order_Value should match:
-- SUM(Quantity * Unit_Price)
--
-- Expected result:
-- EMPTY SET
-- ============================================================

SELECT
    o.Order_ID,
    o.Order_Value,
    SUM(
        od.Quantity * od.Unit_Price
    ) AS Calculated_Order_Value

FROM Orders o

JOIN Order_Details od
    ON o.Order_ID = od.Order_ID

GROUP BY
    o.Order_ID,
    o.Order_Value

HAVING
    o.Order_Value <> SUM(
        od.Quantity * od.Unit_Price
    );


-- ============================================================
-- 15. CHECK ORDERS WITHOUT ORDER DETAILS
-- Expected result:
-- EMPTY SET
-- ============================================================

SELECT
    o.Order_ID
FROM Orders o

LEFT JOIN Order_Details od
    ON o.Order_ID = od.Order_ID

WHERE od.Order_Detail_ID IS NULL;


-- ============================================================
-- 16. CHECK ORDER DETAILS WITH INVALID ORDERS
-- Expected result:
-- EMPTY SET
-- ============================================================

SELECT
    od.Order_Detail_ID,
    od.Order_ID

FROM Order_Details od

LEFT JOIN Orders o
    ON od.Order_ID = o.Order_ID

WHERE o.Order_ID IS NULL;


-- ============================================================
-- 17. CHECK ORDER DETAILS WITH INVALID PRODUCTS
-- Expected result:
-- EMPTY SET
-- ============================================================

SELECT
    od.Order_Detail_ID,
    od.Product_ID

FROM Order_Details od

LEFT JOIN Products p
    ON od.Product_ID = p.Product_ID

WHERE p.Product_ID IS NULL;


-- ============================================================
-- 18. CHECK ORDERS WITH INVALID CUSTOMERS
-- Expected result:
-- EMPTY SET
-- ============================================================

SELECT
    o.Order_ID,
    o.Customer_ID

FROM Orders o

LEFT JOIN Customers c
    ON o.Customer_ID = c.Customer_ID

WHERE c.Customer_ID IS NULL;


-- ============================================================
-- 19. CHECK ORDERS WITH INVALID WAREHOUSES
-- Expected result:
-- EMPTY SET
-- ============================================================

SELECT
    o.Order_ID,
    o.Warehouse_ID

FROM Orders o

LEFT JOIN Warehouses w
    ON o.Warehouse_ID = w.Warehouse_ID

WHERE w.Warehouse_ID IS NULL;


-- ============================================================
-- 20. CHECK SHIPMENTS WITH INVALID ORDERS
-- Expected result:
-- EMPTY SET
-- ============================================================

SELECT
    s.Shipment_ID,
    s.Order_ID

FROM Shipments s

LEFT JOIN Orders o
    ON s.Order_ID = o.Order_ID

WHERE o.Order_ID IS NULL;


-- ============================================================
-- 21. CHECK SHIPMENTS WITH INVALID CARRIERS
-- Expected result:
-- EMPTY SET
-- ============================================================

SELECT
    s.Shipment_ID,
    s.Carrier_ID

FROM Shipments s

LEFT JOIN Carriers c
    ON s.Carrier_ID = c.Carrier_ID

WHERE c.Carrier_ID IS NULL;


-- ============================================================
-- 22. CHECK TRACKING RECORDS WITH INVALID SHIPMENTS
-- Expected result:
-- EMPTY SET
-- ============================================================

SELECT
    dt.Tracking_ID,
    dt.Shipment_ID

FROM Delivery_Tracking dt

LEFT JOIN Shipments s
    ON dt.Shipment_ID = s.Shipment_ID

WHERE s.Shipment_ID IS NULL;


-- ============================================================
-- 23. CHECK RETURNS WITH INVALID ORDERS
-- Expected result:
-- EMPTY SET
-- ============================================================

SELECT
    r.Return_ID,
    r.Order_ID

FROM Returns r

LEFT JOIN Orders o
    ON r.Order_ID = o.Order_ID

WHERE o.Order_ID IS NULL;


-- ============================================================
-- 24. CHECK RETURNS WITH INVALID PRODUCTS
-- Expected result:
-- EMPTY SET
-- ============================================================

SELECT
    r.Return_ID,
    r.Product_ID

FROM Returns r

LEFT JOIN Products p
    ON r.Product_ID = p.Product_ID

WHERE p.Product_ID IS NULL;


-- ============================================================
-- 25. CHECK DUPLICATE CUSTOMER EMAILS
-- Expected result:
-- EMPTY SET
-- ============================================================

SELECT
    Email,
    COUNT(*) AS Email_Count

FROM Customers

GROUP BY Email

HAVING COUNT(*) > 1;


-- ============================================================
-- 26. CHECK DUPLICATE CARRIER NAMES
-- Expected result:
-- EMPTY SET
-- ============================================================

SELECT
    Carrier_Name,
    COUNT(*) AS Carrier_Count

FROM Carriers

GROUP BY Carrier_Name

HAVING COUNT(*) > 1;


-- ============================================================
-- 27. CHECK NEGATIVE / ZERO PRODUCT PRICES
-- Expected result:
-- EMPTY SET
-- ============================================================

SELECT
    Product_ID,
    Product_Name,
    Unit_Price

FROM Products

WHERE Unit_Price <= 0;


-- ============================================================
-- 28. CHECK INVALID ORDER VALUES
-- Expected result:
-- EMPTY SET
-- ============================================================

SELECT
    Order_ID,
    Order_Value

FROM Orders

WHERE Order_Value <= 0;


-- ============================================================
-- 29. CHECK INVALID QUANTITIES
-- Expected result:
-- EMPTY SET
-- ============================================================

SELECT
    Order_Detail_ID,
    Quantity

FROM Order_Details

WHERE Quantity <= 0;


-- ============================================================
-- 30. CHECK INVALID RETURN QUANTITIES
-- Expected result:
-- EMPTY SET
-- ============================================================

SELECT
    Return_ID,
    Return_Quantity

FROM Returns

WHERE Return_Quantity <= 0;


-- ============================================================
-- 31. CHECK SHIPMENT DELIVERY DATES
--
-- Actual delivery should not be before shipment date
-- Expected result:
-- EMPTY SET
-- ============================================================

SELECT
    Shipment_ID,
    Shipment_Date,
    Actual_Delivery

FROM Shipments

WHERE Actual_Delivery IS NOT NULL
  AND Actual_Delivery < Shipment_Date;


-- ============================================================
-- 32. CHECK EXPECTED DELIVERY DATE
--
-- Expected delivery should not be before shipment date
-- Expected result:
-- EMPTY SET
-- ============================================================

SELECT
    Shipment_ID,
    Shipment_Date,
    Expected_Delivery

FROM Shipments

WHERE Expected_Delivery < Shipment_Date;


-- ============================================================
-- 33. CHECK SHIPMENT STATUS
-- ============================================================

SELECT
    Shipment_Status,
    COUNT(*) AS Shipment_Count

FROM Shipments

GROUP BY Shipment_Status

ORDER BY Shipment_Status;


-- ============================================================
-- 34. CHECK ORDER STATUS
-- ============================================================

SELECT
    Order_Status,
    COUNT(*) AS Order_Count

FROM Orders

GROUP BY Order_Status

ORDER BY Order_Status;


-- ============================================================
-- 35. CHECK DELIVERED SHIPMENTS
-- ============================================================

SELECT
    COUNT(*) AS Delivered_Shipments

FROM Shipments

WHERE Shipment_Status = 'DELIVERED'
  AND Actual_Delivery IS NOT NULL;


-- ============================================================
-- 36. CHECK SLA STATUS COUNTS
-- ============================================================

SELECT
    CASE
        WHEN Actual_Delivery <= Expected_Delivery
            THEN 'ON TIME'
        ELSE 'SLA BREACHED'
    END AS SLA_Status,

    COUNT(*) AS Shipment_Count

FROM Shipments

WHERE Actual_Delivery IS NOT NULL

GROUP BY
    CASE
        WHEN Actual_Delivery <= Expected_Delivery
            THEN 'ON TIME'
        ELSE 'SLA BREACHED'
    END;


-- ============================================================
-- 37. CHECK SHIPMENTS PER CARRIER
-- ============================================================

SELECT
    c.Carrier_ID,
    c.Carrier_Name,
    c.Region,
    COUNT(s.Shipment_ID) AS Shipment_Count

FROM Carriers c

LEFT JOIN Shipments s
    ON c.Carrier_ID = s.Carrier_ID

GROUP BY
    c.Carrier_ID,
    c.Carrier_Name,
    c.Region

ORDER BY
    c.Region,
    Shipment_Count DESC;


-- ============================================================
-- 38. CHECK SHIPMENTS PER REGION
-- ============================================================

SELECT
    c.Region,
    COUNT(s.Shipment_ID) AS Shipment_Count

FROM Carriers c

JOIN Shipments s
    ON c.Carrier_ID = s.Carrier_ID

GROUP BY c.Region

ORDER BY Shipment_Count DESC;


-- ============================================================
-- 39. CHECK SHIPMENT DATE RANGE
-- ============================================================

SELECT
    MIN(Shipment_Date) AS First_Shipment_Date,
    MAX(Shipment_Date) AS Last_Shipment_Date

FROM Shipments;


-- ============================================================
-- 40. CHECK ORDER DATE RANGE
-- ============================================================

SELECT
    MIN(Order_Date) AS First_Order_Date,
    MAX(Order_Date) AS Last_Order_Date

FROM Orders;


-- ============================================================
-- 41. CHECK VIEW
-- Expected:
-- View should exist
-- ============================================================

SHOW FULL TABLES
WHERE Table_Type = 'VIEW';


-- ============================================================
-- 42. CHECK SHIPMENT PERFORMANCE VIEW
-- ============================================================

SELECT *
FROM Shipment_Performance_View
LIMIT 10;


-- ============================================================
-- 43. CHECK VIEW ROW COUNT
-- ============================================================

SELECT
    COUNT(*) AS View_Row_Count

FROM Shipment_Performance_View;


-- ============================================================
-- 44. CHECK INDEXES ON CUSTOMERS
-- ============================================================

SHOW INDEX FROM Customers;


-- ============================================================
-- 45. CHECK INDEXES ON ORDERS
-- ============================================================

SHOW INDEX FROM Orders;


-- ============================================================
-- 46. CHECK INDEXES ON SHIPMENTS
-- ============================================================

SHOW INDEX FROM Shipments;


-- ============================================================
-- 47. CHECK PRIMARY KEYS
-- ============================================================

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME

FROM information_schema.KEY_COLUMN_USAGE

WHERE TABLE_SCHEMA = DATABASE()
  AND CONSTRAINT_NAME = 'PRIMARY'

ORDER BY TABLE_NAME;


-- ============================================================
-- 48. CHECK FOREIGN KEYS
-- ============================================================

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME

FROM information_schema.KEY_COLUMN_USAGE

WHERE TABLE_SCHEMA = DATABASE()
  AND REFERENCED_TABLE_NAME IS NOT NULL

ORDER BY
    TABLE_NAME,
    COLUMN_NAME;


-- ============================================================
-- 49. FINAL PROJECT HEALTH CHECK
--
-- This provides a quick summary of major tables.
-- ============================================================

SELECT
    (SELECT COUNT(*) FROM Customers) AS Customers,
    (SELECT COUNT(*) FROM Products) AS Products,
    (SELECT COUNT(*) FROM Warehouses) AS Warehouses,
    (SELECT COUNT(*) FROM Orders) AS Orders,
    (SELECT COUNT(*) FROM Order_Details) AS Order_Details,
    (SELECT COUNT(*) FROM Carriers) AS Carriers,
    (SELECT COUNT(*) FROM Shipments) AS Shipments,
    (SELECT COUNT(*) FROM Delivery_Tracking) AS Tracking_Records,
    (SELECT COUNT(*) FROM Returns) AS Returns;


-- ============================================================
-- END OF VALIDATION QUERIES
-- ============================================================