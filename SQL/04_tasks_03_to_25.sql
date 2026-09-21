USE supply_chain_db;


-- ============================================================
-- SQL MINI PROJECT
-- Supply Chain Shipment & Delivery SLA Analytics
-- Tasks 03 to 25
-- ============================================================


-- ============================================================
-- TASK 03
-- Display all orders along with:
-- Customer Name, Order Date, Warehouse,
-- Order Value, and Order Status
-- ============================================================

SELECT
    o.Order_ID,
    c.Customer_Name,
    o.Order_Date,
    w.Warehouse_Name,
    o.Order_Value,
    o.Order_Status
FROM Orders o
JOIN Customers c
    ON o.Customer_ID = c.Customer_ID
JOIN Warehouses w
    ON o.Warehouse_ID = w.Warehouse_ID
ORDER BY o.Order_ID;


-- ============================================================
-- TASK 04
-- Find the top 10 customers based on total order value
-- ============================================================

SELECT
    c.Customer_ID,
    c.Customer_Name,
    SUM(o.Order_Value) AS Total_Order_Value
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name
ORDER BY Total_Order_Value DESC
LIMIT 10;


-- ============================================================
-- TASK 05
-- Find customers who have never placed an order
-- ============================================================

SELECT
    c.Customer_ID,
    c.Customer_Name,
    c.Email,
    c.Region,
    c.City
FROM Customers c
LEFT JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
WHERE o.Order_ID IS NULL;


-- ============================================================
-- TASK 06
-- Calculate the total number of shipments by carrier
-- ============================================================

SELECT
    c.Carrier_ID,
    c.Carrier_Name,
    COUNT(s.Shipment_ID) AS Total_Shipments
FROM Carriers c
LEFT JOIN Shipments s
    ON c.Carrier_ID = s.Carrier_ID
GROUP BY
    c.Carrier_ID,
    c.Carrier_Name
ORDER BY Total_Shipments DESC;


-- ============================================================
-- TASK 07
-- Identify shipments delivered after the expected delivery date
-- ============================================================

SELECT
    s.Shipment_ID,
    s.Order_ID,
    c.Carrier_Name,
    s.Shipment_Date,
    s.Expected_Delivery,
    s.Actual_Delivery,
    DATEDIFF(
        s.Actual_Delivery,
        s.Expected_Delivery
    ) AS Days_Late
FROM Shipments s
JOIN Carriers c
    ON s.Carrier_ID = c.Carrier_ID
WHERE s.Actual_Delivery > s.Expected_Delivery
ORDER BY Days_Late DESC;


-- ============================================================
-- TASK 08
-- Calculate the number of delivery days
-- for every completed shipment
-- ============================================================

SELECT
    Shipment_ID,
    Order_ID,
    Shipment_Date,
    Actual_Delivery,
    DATEDIFF(
        Actual_Delivery,
        Shipment_Date
    ) AS Delivery_Days
FROM Shipments
WHERE Shipment_Status = 'DELIVERED'
  AND Actual_Delivery IS NOT NULL
ORDER BY Shipment_ID;


-- ============================================================
-- TASK 09
-- Create SLA Status:
-- ON TIME
-- SLA BREACHED
-- ============================================================

SELECT
    s.Shipment_ID,
    s.Order_ID,
    s.Expected_Delivery,
    s.Actual_Delivery,

    CASE
        WHEN s.Actual_Delivery <= s.Expected_Delivery
            THEN 'ON TIME'
        ELSE 'SLA BREACHED'
    END AS SLA_Status

FROM Shipments s
WHERE s.Actual_Delivery IS NOT NULL
ORDER BY s.Shipment_ID;


-- ============================================================
-- TASK 10
-- Calculate SLA compliance percentage for each carrier
-- ============================================================

SELECT
    c.Carrier_ID,
    c.Carrier_Name,

    COUNT(s.Shipment_ID) AS Total_Shipments,

    SUM(
        CASE
            WHEN s.Actual_Delivery <= s.Expected_Delivery
                THEN 1
            ELSE 0
        END
    ) AS On_Time_Shipments,

    SUM(
        CASE
            WHEN s.Actual_Delivery > s.Expected_Delivery
                THEN 1
            ELSE 0
        END
    ) AS SLA_Breached_Shipments,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN s.Actual_Delivery <= s.Expected_Delivery
                    THEN 1
                ELSE 0
            END
        )
        / COUNT(s.Shipment_ID),
        2
    ) AS SLA_Compliance_Percentage

FROM Carriers c
JOIN Shipments s
    ON c.Carrier_ID = s.Carrier_ID

GROUP BY
    c.Carrier_ID,
    c.Carrier_Name

ORDER BY SLA_Compliance_Percentage DESC;


-- ============================================================
-- TASK 11
-- Find the best and worst-performing delivery carriers
-- based on SLA compliance
-- ============================================================

WITH Carrier_Performance AS
(
    SELECT
        c.Carrier_ID,
        c.Carrier_Name,

        COUNT(s.Shipment_ID) AS Total_Shipments,

        ROUND(
            100.0 *
            SUM(
                CASE
                    WHEN s.Actual_Delivery <= s.Expected_Delivery
                        THEN 1
                    ELSE 0
                END
            )
            / COUNT(s.Shipment_ID),
            2
        ) AS SLA_Compliance_Percentage

    FROM Carriers c
    JOIN Shipments s
        ON c.Carrier_ID = s.Carrier_ID

    GROUP BY
        c.Carrier_ID,
        c.Carrier_Name
)

SELECT
    Carrier_ID,
    Carrier_Name,
    Total_Shipments,
    SLA_Compliance_Percentage,

    CASE
        WHEN SLA_Compliance_Percentage =
             MAX(SLA_Compliance_Percentage) OVER ()
            THEN 'BEST PERFORMING'

        WHEN SLA_Compliance_Percentage =
             MIN(SLA_Compliance_Percentage) OVER ()
            THEN 'WORST PERFORMING'

        ELSE 'OTHER'
    END AS Performance_Category

FROM Carrier_Performance

ORDER BY SLA_Compliance_Percentage DESC;


-- ============================================================
-- TASK 12
-- Find the top 3 carriers in each region
-- using a window function
-- ============================================================

WITH Carrier_Performance AS
(
    SELECT
        c.Region,
        c.Carrier_ID,
        c.Carrier_Name,

        COUNT(s.Shipment_ID) AS Total_Shipments,

        SUM(
            CASE
                WHEN s.Actual_Delivery <= s.Expected_Delivery
                    THEN 1
                ELSE 0
            END
        ) AS On_Time_Shipments,

        ROUND(
            100.0 *
            SUM(
                CASE
                    WHEN s.Actual_Delivery <= s.Expected_Delivery
                        THEN 1
                    ELSE 0
                END
            )
            / COUNT(s.Shipment_ID),
            2
        ) AS SLA_Compliance_Percentage

    FROM Carriers c
    JOIN Shipments s
        ON c.Carrier_ID = s.Carrier_ID

    GROUP BY
        c.Region,
        c.Carrier_ID,
        c.Carrier_Name
),

Ranked_Carriers AS
(
    SELECT
        Region,
        Carrier_ID,
        Carrier_Name,
        Total_Shipments,
        On_Time_Shipments,
        SLA_Compliance_Percentage,

        RANK() OVER
        (
            PARTITION BY Region
            ORDER BY SLA_Compliance_Percentage DESC
        ) AS Regional_Rank

    FROM Carrier_Performance
)

SELECT
    Region,
    Carrier_ID,
    Carrier_Name,
    Total_Shipments,
    On_Time_Shipments,
    SLA_Compliance_Percentage,
    Regional_Rank

FROM Ranked_Carriers

WHERE Regional_Rank <= 3

ORDER BY
    Region,
    Regional_Rank;


-- ============================================================
-- TASK 13
-- Calculate average delivery time for each warehouse
-- ============================================================

SELECT
    w.Warehouse_ID,
    w.Warehouse_Name,

    ROUND(
        AVG(
            DATEDIFF(
                s.Actual_Delivery,
                s.Shipment_Date
            )
        ),
        2
    ) AS Average_Delivery_Days

FROM Warehouses w

JOIN Orders o
    ON w.Warehouse_ID = o.Warehouse_ID

JOIN Shipments s
    ON o.Order_ID = s.Order_ID

WHERE s.Shipment_Status = 'DELIVERED'
  AND s.Actual_Delivery IS NOT NULL

GROUP BY
    w.Warehouse_ID,
    w.Warehouse_Name

ORDER BY Average_Delivery_Days ASC;


-- ============================================================
-- TASK 14
-- Identify warehouses having the highest number
-- of delayed shipments
-- ============================================================

SELECT
    w.Warehouse_ID,
    w.Warehouse_Name,

    COUNT(
        CASE
            WHEN s.Actual_Delivery > s.Expected_Delivery
                THEN s.Shipment_ID
        END
    ) AS Delayed_Shipments

FROM Warehouses w

JOIN Orders o
    ON w.Warehouse_ID = o.Warehouse_ID

JOIN Shipments s
    ON o.Order_ID = s.Order_ID

GROUP BY
    w.Warehouse_ID,
    w.Warehouse_Name

ORDER BY Delayed_Shipments DESC;


-- ============================================================
-- TASK 15
-- Calculate monthly:
-- Total Orders
-- Total Shipments
-- Delivered Shipments
-- Delayed Shipments
-- SLA Compliance %
-- ============================================================

WITH Monthly_Orders AS
(
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m') AS Order_Month,
        COUNT(*) AS Total_Orders
    FROM Orders
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
),

Monthly_Shipments AS
(
    SELECT
        DATE_FORMAT(Shipment_Date, '%Y-%m') AS Shipment_Month,

        COUNT(*) AS Total_Shipments,

        SUM(
            CASE
                WHEN Shipment_Status = 'DELIVERED'
                    THEN 1
                ELSE 0
            END
        ) AS Delivered_Shipments,

        SUM(
            CASE
                WHEN Actual_Delivery > Expected_Delivery
                    THEN 1
                ELSE 0
            END
        ) AS Delayed_Shipments,

        ROUND(
            100.0 *
            SUM(
                CASE
                    WHEN Actual_Delivery <= Expected_Delivery
                        THEN 1
                    ELSE 0
                END
            )
            / COUNT(*),
            2
        ) AS SLA_Compliance_Percentage

    FROM Shipments

    GROUP BY DATE_FORMAT(Shipment_Date, '%Y-%m')
)

SELECT
    COALESCE(o.Order_Month, s.Shipment_Month) AS Month,
    COALESCE(o.Total_Orders, 0) AS Total_Orders,
    COALESCE(s.Total_Shipments, 0) AS Total_Shipments,
    COALESCE(s.Delivered_Shipments, 0) AS Delivered_Shipments,
    COALESCE(s.Delayed_Shipments, 0) AS Delayed_Shipments,
    COALESCE(s.SLA_Compliance_Percentage, 0)
        AS SLA_Compliance_Percentage

FROM Monthly_Orders o

LEFT JOIN Monthly_Shipments s
    ON o.Order_Month = s.Shipment_Month

ORDER BY Month;


-- ============================================================
-- TASK 16
-- Find the region with the highest SLA breach percentage
-- ============================================================

SELECT
    c.Region,

    COUNT(s.Shipment_ID) AS Total_Shipments,

    SUM(
        CASE
            WHEN s.Actual_Delivery > s.Expected_Delivery
                THEN 1
            ELSE 0
        END
    ) AS SLA_Breached_Shipments,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN s.Actual_Delivery > s.Expected_Delivery
                    THEN 1
                ELSE 0
            END
        )
        / COUNT(s.Shipment_ID),
        2
    ) AS SLA_Breach_Percentage

FROM Carriers c

JOIN Shipments s
    ON c.Carrier_ID = s.Carrier_ID

GROUP BY c.Region

ORDER BY SLA_Breach_Percentage DESC

LIMIT 1;


-- ============================================================
-- TASK 17
-- Identify products having the highest return rate
--
-- Return Rate =
-- Returned Quantity / Sold Quantity * 100
-- ============================================================


WITH Sold_Quantity AS
(
    SELECT
        Product_ID,
        SUM(Quantity) AS Total_Sold_Quantity
    FROM Order_Details
    GROUP BY Product_ID
),

Returned_Quantity AS
(
    SELECT
        Product_ID,
        SUM(Return_Quantity) AS Total_Returned_Quantity
    FROM Returns
    GROUP BY Product_ID
)

SELECT
    p.Product_ID,
    p.Product_Name,

    COALESCE(sq.Total_Sold_Quantity, 0)
        AS Total_Sold_Quantity,

    COALESCE(rq.Total_Returned_Quantity, 0)
        AS Total_Returned_Quantity,

    ROUND(
        100.0 *
        COALESCE(rq.Total_Returned_Quantity, 0)
        / NULLIF(sq.Total_Sold_Quantity, 0),
        2
    ) AS Return_Rate_Percentage

FROM Products p

LEFT JOIN Sold_Quantity sq
    ON p.Product_ID = sq.Product_ID

LEFT JOIN Returned_Quantity rq
    ON p.Product_ID = rq.Product_ID

ORDER BY Return_Rate_Percentage DESC;

-- ============================================================
-- TASK 18
-- Find customers who placed more than 5 orders
-- and had at least one returned product
-- ============================================================

SELECT
    c.Customer_ID,
    c.Customer_Name,
    COUNT(DISTINCT o.Order_ID) AS Total_Orders,
    COUNT(DISTINCT r.Return_ID) AS Total_Returns

FROM Customers c

JOIN Orders o
    ON c.Customer_ID = o.Customer_ID

JOIN Returns r
    ON o.Order_ID = r.Order_ID

GROUP BY
    c.Customer_ID,
    c.Customer_Name

HAVING COUNT(DISTINCT o.Order_ID) > 5
   AND COUNT(DISTINCT r.Return_ID) >= 1

ORDER BY Total_Orders DESC;


-- ============================================================
-- TASK 19
-- Identify shipments that had multiple tracking updates
-- before delivery
-- ============================================================

SELECT
    s.Shipment_ID,
    s.Order_ID,

    COUNT(dt.Tracking_ID) AS Tracking_Updates_Before_Delivery

FROM Shipments s

JOIN Delivery_Tracking dt
    ON s.Shipment_ID = dt.Shipment_ID

WHERE dt.Tracking_Date < s.Actual_Delivery

GROUP BY
    s.Shipment_ID,
    s.Order_ID

HAVING COUNT(dt.Tracking_ID) > 1

ORDER BY Tracking_Updates_Before_Delivery DESC;


-- ============================================================
-- TASK 20
-- Find orders where:
-- 1. Shipment was delivered late
-- 2. Order value was greater than average order value
-- ============================================================

SELECT
    o.Order_ID,
    c.Customer_Name,
    o.Order_Value,
    s.Expected_Delivery,
    s.Actual_Delivery,

    DATEDIFF(
        s.Actual_Delivery,
        s.Expected_Delivery
    ) AS Days_Late

FROM Orders o

JOIN Customers c
    ON o.Customer_ID = c.Customer_ID

JOIN Shipments s
    ON o.Order_ID = s.Order_ID

WHERE s.Actual_Delivery > s.Expected_Delivery

  AND o.Order_Value >
      (
          SELECT AVG(Order_Value)
          FROM Orders
      )

ORDER BY o.Order_Value DESC;


-- ============================================================
-- TASK 21
-- Rank warehouses based on delivery performance
-- using RANK()
--
-- Performance is measured using SLA compliance percentage
-- ============================================================

WITH Warehouse_Performance AS
(
    SELECT
        w.Warehouse_ID,
        w.Warehouse_Name,

        COUNT(s.Shipment_ID) AS Total_Shipments,

        SUM(
            CASE
                WHEN s.Actual_Delivery <= s.Expected_Delivery
                    THEN 1
                ELSE 0
            END
        ) AS On_Time_Shipments,

        ROUND(
            100.0 *
            SUM(
                CASE
                    WHEN s.Actual_Delivery <= s.Expected_Delivery
                        THEN 1
                    ELSE 0
                END
            )
            / COUNT(s.Shipment_ID),
            2
        ) AS SLA_Compliance_Percentage

    FROM Warehouses w

    JOIN Orders o
        ON w.Warehouse_ID = o.Warehouse_ID

    JOIN Shipments s
        ON o.Order_ID = s.Order_ID

    GROUP BY
        w.Warehouse_ID,
        w.Warehouse_Name
)

SELECT
    Warehouse_ID,
    Warehouse_Name,
    Total_Shipments,
    On_Time_Shipments,
    SLA_Compliance_Percentage,

    RANK() OVER
    (
        ORDER BY SLA_Compliance_Percentage DESC
    ) AS Warehouse_Rank

FROM Warehouse_Performance

ORDER BY Warehouse_Rank;


-- ============================================================
-- TASK 22
-- Find the second-highest performing carrier
-- based on SLA compliance
-- ============================================================

WITH Carrier_Performance AS
(
    SELECT
        c.Carrier_ID,
        c.Carrier_Name,

        ROUND(
            100.0 *
            SUM(
                CASE
                    WHEN s.Actual_Delivery <= s.Expected_Delivery
                        THEN 1
                    ELSE 0
                END
            )
            / COUNT(s.Shipment_ID),
            2
        ) AS SLA_Compliance_Percentage

    FROM Carriers c

    JOIN Shipments s
        ON c.Carrier_ID = s.Carrier_ID

    GROUP BY
        c.Carrier_ID,
        c.Carrier_Name
),

Ranked_Carriers AS
(
    SELECT
        Carrier_ID,
        Carrier_Name,
        SLA_Compliance_Percentage,

        DENSE_RANK() OVER
        (
            ORDER BY SLA_Compliance_Percentage DESC
        ) AS Performance_Rank

    FROM Carrier_Performance
)

SELECT
    Carrier_ID,
    Carrier_Name,
    SLA_Compliance_Percentage,
    Performance_Rank

FROM Ranked_Carriers

WHERE Performance_Rank = 2;


-- ============================================================
-- TASK 23
-- Create a CTE to identify customers whose
-- total spending is greater than average customer spending
-- ============================================================

WITH Customer_Spending AS
(
    SELECT
        c.Customer_ID,
        c.Customer_Name,

        SUM(o.Order_Value) AS Total_Spending

    FROM Customers c

    JOIN Orders o
        ON c.Customer_ID = o.Customer_ID

    GROUP BY
        c.Customer_ID,
        c.Customer_Name
),

Average_Customer_Spending AS
(
    SELECT
        AVG(Total_Spending) AS Average_Spending
    FROM Customer_Spending
)

SELECT
    cs.Customer_ID,
    cs.Customer_Name,
    cs.Total_Spending,
    acs.Average_Spending

FROM Customer_Spending cs

CROSS JOIN Average_Customer_Spending acs

WHERE cs.Total_Spending > acs.Average_Spending

ORDER BY cs.Total_Spending DESC;


-- ============================================================
-- TASK 24
-- Create VIEW:
-- Shipment_Performance_View
--
-- Columns:
-- Order ID
-- Customer
-- Warehouse
-- Carrier
-- Shipment Date
-- Expected Delivery
-- Actual Delivery
-- Delivery Days
-- SLA Status
-- ============================================================

CREATE OR REPLACE VIEW Shipment_Performance_View AS

SELECT
    o.Order_ID AS Order_ID,
    c.Customer_Name AS Customer,
    w.Warehouse_Name AS Warehouse,
    cr.Carrier_Name AS Carrier,

    s.Shipment_Date,
    s.Expected_Delivery,
    s.Actual_Delivery,

    DATEDIFF(
        s.Actual_Delivery,
        s.Shipment_Date
    ) AS Delivery_Days,

    CASE
        WHEN s.Actual_Delivery <= s.Expected_Delivery
            THEN 'ON TIME'
        ELSE 'SLA BREACHED'
    END AS SLA_Status

FROM Orders o

JOIN Customers c
    ON o.Customer_ID = c.Customer_ID

JOIN Warehouses w
    ON o.Warehouse_ID = w.Warehouse_ID

JOIN Shipments s
    ON o.Order_ID = s.Order_ID

JOIN Carriers cr
    ON s.Carrier_ID = cr.Carrier_ID;


-- Verify the View

SELECT *
FROM Shipment_Performance_View
ORDER BY Order_ID;


-- ============================================================
-- TASK 25
-- Create indexes to improve query performance
-- ============================================================

CREATE INDEX idx_customers_customer_id
ON Customers(Customer_ID);

CREATE INDEX idx_orders_order_id
ON Orders(Order_ID);

CREATE INDEX idx_shipments_shipment_id
ON Shipments(Shipment_ID);

CREATE INDEX idx_shipments_carrier_id
ON Shipments(Carrier_ID);

CREATE INDEX idx_shipments_shipment_date
ON Shipments(Shipment_Date);


-- ============================================================
-- FINAL VERIFICATION
-- ============================================================

-- Verify View
SELECT *
FROM Shipment_Performance_View
LIMIT 10;


-- Verify Indexes
SHOW INDEX FROM Customers;

SHOW INDEX FROM Orders;

SHOW INDEX FROM Shipments;