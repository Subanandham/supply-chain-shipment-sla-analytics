1. Customers
2. Products
3. Warehouses
4. Carriers
5. Orders
6. Order_Details
7. Shipments
8. Delivery_Tracking
9. Returns

INSERT INTO Customers
(Customer_ID, Customer_Name, Email, Phone, Region, City, Created_Date)
VALUES
(1, 'Arun Kumar', 'arun.kumar@gmail.com', '9876500001', 'South', 'Chennai', '2025-01-10'),
(2, 'Priya Sharma', 'priya.sharma@gmail.com', '9876500002', 'South', 'Bangalore', '2025-01-15'),
(3, 'Rahul Verma', 'rahul.verma@gmail.com', '9876500003', 'North', 'Delhi', '2025-02-05'),
(4, 'Sneha Iyer', 'sneha.iyer@gmail.com', '9876500004', 'South', 'Coimbatore', '2025-02-12'),
(5, 'Vikram Singh', 'vikram.singh@gmail.com', '9876500005', 'West', 'Mumbai', '2025-03-01'),
(6, 'Anjali Mehta', 'anjali.mehta@gmail.com', '9876500006', 'West', 'Pune', '2025-03-10'),
(7, 'Karthik Raj', 'karthik.raj@gmail.com', '9876500007', 'South', 'Chennai', '2025-03-20'),
(8, 'Meera Nair', 'meera.nair@gmail.com', '9876500008', 'South', 'Kochi', '2025-04-01'),
(9, 'Sanjay Patel', 'sanjay.patel@gmail.com', '9876500009', 'West', 'Ahmedabad', '2025-04-15'),
(10, 'Divya Rao', 'divya.rao@gmail.com', '9876500010', 'East', 'Kolkata', '2025-05-01'),
(11, 'Rohan Das', 'rohan.das@gmail.com', '9876500011', 'East', 'Bhubaneswar', '2025-05-15'),
(12, 'Neha Kapoor', 'neha.kapoor@gmail.com', '9876500012', 'North', 'Delhi', '2025-06-01'),
(13, 'Ajay Menon', 'ajay.menon@gmail.com', '9876500013', 'South', 'Hyderabad', '2025-06-15'),
(14, 'Pooja Shah', 'pooja.shah@gmail.com', '9876500014', 'West', 'Mumbai', '2025-07-01'),
(15, 'Naveen Kumar', 'naveen.kumar@gmail.com', '9876500015', 'North', 'Jaipur', '2025-07-15');

INSERT INTO Products
(Product_ID, Product_Name, Category, Unit_Price, Weight_KG, Returnable)
VALUES
(1, 'Laptop', 'Electronics', 65000.00, 2.50, 'Y'),
(2, 'Smartphone', 'Electronics', 35000.00, 0.50, 'Y'),
(3, 'Wireless Headphones', 'Electronics', 5000.00, 0.30, 'Y'),
(4, 'Mechanical Keyboard', 'Accessories', 4500.00, 0.90, 'Y'),
(5, 'Wireless Mouse', 'Accessories', 1800.00, 0.20, 'Y'),
(6, 'Monitor', 'Electronics', 22000.00, 5.00, 'Y'),
(7, 'Office Chair', 'Furniture', 12000.00, 12.00, 'Y'),
(8, 'Standing Desk', 'Furniture', 28000.00, 25.00, 'Y'),
(9, 'Webcam', 'Electronics', 3500.00, 0.40, 'Y'),
(10, 'USB-C Hub', 'Accessories', 2500.00, 0.25, 'Y');

INSERT INTO Warehouses
(Warehouse_ID, Warehouse_Name, Region, City, Capacity)
VALUES
(1, 'Chennai Central Hub', 'South', 'Chennai', 10000),
(2, 'Bangalore Distribution Hub', 'South', 'Bangalore', 12000),
(3, 'Hyderabad Logistics Hub', 'South', 'Hyderabad', 9000),
(4, 'Mumbai West Hub', 'West', 'Mumbai', 15000),
(5, 'Pune Distribution Hub', 'West', 'Pune', 8000),
(6, 'Delhi North Hub', 'North', 'Delhi', 14000),
(7, 'Jaipur North Hub', 'North', 'Jaipur', 7000),
(8, 'Kolkata East Hub', 'East', 'Kolkata', 11000);

INSERT INTO Carriers
(Carrier_ID, Carrier_Name, Region, Contact_Number, SLA_Days)
VALUES
(1, 'BlueDart', 'South', '180010001', 3),
(2, 'Delhivery', 'North', '180010002', 4),
(3, 'DHL', 'West', '180010003', 3),
(4, 'FedEx', 'East', '180010004', 5),
(5, 'Ecom Express', 'South', '180010005', 4),
(6, 'XpressBees', 'West', '180010006', 5),
(7, 'DTDC', 'North', '180010007', 3),
(8, 'Shadowfax', 'East', '180010008', 4);

INSERT INTO Orders
(Order_ID, Customer_ID, Warehouse_ID, Order_Date, Order_Status, Order_Value)
VALUES
(101, 1, 1, '2026-01-05', 'DELIVERED', 68600.00),
(102, 1, 1, '2026-01-18', 'DELIVERED', 45000.00),
(103, 1, 2, '2026-02-03', 'DELIVERED', 28000.00),
(104, 1, 3, '2026-02-05', 'DELIVERED', 43000.00),
(105, 1, 1, '2026-02-15', 'DELIVERED', 65000.00),
(106, 1, 2, '2026-02-20', 'DELIVERED', 14400.00),

(107, 2, 2, '2026-01-08', 'DELIVERED', 35000.00),
(108, 2, 2, '2026-01-25', 'DELIVERED', 47000.00),
(109, 2, 3, '2026-02-01', 'DELIVERED', 28000.00),
(110, 2, 2, '2026-02-11', 'DELIVERED', 65000.00),
(111, 2, 3, '2026-02-12', 'DELIVERED', 21000.00),
(112, 2, 1, '2026-02-15', 'DELIVERED', 35000.00),

(113, 3, 6, '2026-02-10', 'DELIVERED', 22000.00),
(114, 3, 6, '2026-02-12', 'DELIVERED', 65000.00),

(115, 4, 1, '2026-02-16', 'DELIVERED', 12000.00),
(116, 4, 3, '2026-02-20', 'DELIVERED', 28000.00),
(117, 4, 1, '2026-02-21', 'DELIVERED', 74000.00),

(118, 5, 4, '2026-02-23', 'DELIVERED', 35000.00),
(119, 5, 5, '2026-02-24', 'DELIVERED', 5000.00),

(120, 6, 5, '2026-02-25', 'DELIVERED', 22000.00),
(121, 6, 4, '2026-02-26', 'DELIVERED', 35000.00),

(122, 7, 1, '2026-03-02', 'DELIVERED', 65000.00),
(123, 7, 2, '2026-03-03', 'DELIVERED', 18000.00),

(124, 8, 3, '2026-03-04', 'DELIVERED', 3500.00),
(125, 8, 1, '2026-03-05', 'DELIVERED', 12000.00),

(126, 9, 4, '2026-03-06', 'DELIVERED', 28000.00),
(127, 9, 5, '2026-03-07', 'DELIVERED', 4500.00),

(128, 10, 8, '2026-03-08', 'DELIVERED', 35000.00),
(129, 10, 8, '2026-03-09', 'DELIVERED', 22000.00),

(130, 11, 8, '2026-03-10', 'DELIVERED', 5000.00),
(131, 11, 8, '2026-03-10', 'DELIVERED', 28000.00),

(132, 12, 6, '2026-03-12', 'DELIVERED', 65000.00),
(133, 12, 7, '2026-03-13', 'DELIVERED', 12000.00),

(134, 13, 3, '2026-03-14', 'DELIVERED', 45000.00),
(135, 13, 1, '2026-03-15', 'DELIVERED', 65000.00),

(136, 14, 4, '2026-03-16', 'DELIVERED', 35000.00),
(137, 14, 5, '2026-03-17', 'DELIVERED', 22000.00),

(138, 1, 1, '2026-03-18', 'DELIVERED', 87000.00),
(139, 2, 2, '2026-03-19', 'DELIVERED', 55000.00),
(140, 3, 6, '2026-03-20', 'DELIVERED', 65000.00);

INSERT INTO Order_Details
(Order_Detail_ID, Order_ID, Product_ID, Quantity, Unit_Price)
VALUES
(1, 101, 1, 1, 65000),
(2, 101, 5, 2, 1800),

(3, 102, 2, 1, 35000),
(4, 102, 3, 2, 5000),

(5, 103, 8, 1, 28000),

(6, 104, 6, 1, 22000),
(7, 104, 7, 1, 12000),
(8, 104, 5, 5, 1800),

(9, 105, 1, 1, 65000),
(10, 106, 4, 2, 4500),
(11, 106, 5, 3, 1800),

(12, 107, 2, 1, 35000),
(13, 108, 6, 1, 22000),
(14, 108, 3, 5, 5000),
(15, 109, 8, 1, 28000),
(16, 110, 1, 1, 65000),
(17, 111, 7, 1, 12000),
(18, 111, 5, 5, 1800),
(19, 112, 2, 1, 35000),

(20, 113, 6, 1, 22000),
(21, 114, 1, 1, 65000),

(22, 115, 7, 1, 12000),
(23, 116, 8, 1, 28000),
(24, 117, 1, 1, 65000),
(25, 117, 4, 2, 4500),

(26, 118, 2, 1, 35000),
(27, 119, 3, 1, 5000),

(28, 120, 6, 1, 22000),
(29, 121, 2, 1, 35000),

(30, 122, 1, 1, 65000),
(31, 123, 5, 10, 1800),

(32, 124, 9, 1, 3500),
(33, 125, 7, 1, 12000),

(34, 126, 8, 1, 28000),
(35, 127, 4, 1, 4500),

(36, 128, 2, 1, 35000),
(37, 129, 6, 1, 22000),

(38, 130, 3, 1, 5000),
(39, 131, 8, 1, 28000),

(40, 132, 1, 1, 65000),
(41, 133, 7, 1, 12000),

(42, 134, 4, 10, 4500),
(43, 135, 1, 1, 65000),

(44, 136, 2, 1, 35000),
(45, 137, 6, 1, 22000),

(46, 138, 1, 1, 65000),
(47, 138, 6, 1, 22000),

(48, 139, 2, 1, 35000),
(49, 139, 3, 4, 5000),

(50, 140, 1, 1, 65000);

INSERT INTO Shipments
(Shipment_ID, Order_ID, Carrier_ID, Shipment_Date, Expected_Delivery, Actual_Delivery, Shipment_Status)
VALUES
(201, 101, 1, '2026-01-06', '2026-01-09', '2026-01-09', 'DELIVERED'),
(202, 102, 1, '2026-01-19', '2026-01-22', '2026-01-24', 'DELIVERED'),
(203, 103, 5, '2026-02-04', '2026-02-08', '2026-02-07', 'DELIVERED'),
(204, 104, 5, '2026-02-05', '2026-02-09', '2026-02-11', 'DELIVERED'),
(205, 105, 1, '2026-02-15', '2026-02-18', '2026-02-18', 'DELIVERED'),
(206, 106, 5, '2026-02-20', '2026-02-24', '2026-02-26', 'DELIVERED'),

(207, 107, 1, '2026-01-09', '2026-01-12', '2026-01-12', 'DELIVERED'),
(208, 108, 5, '2026-01-26', '2026-01-30', '2026-02-02', 'DELIVERED'),
(209, 109, 5, '2026-02-01', '2026-02-05', '2026-02-05', 'DELIVERED'),
(210, 110, 1, '2026-02-11', '2026-02-14', '2026-02-17', 'DELIVERED'),
(211, 111, 5, '2026-02-12', '2026-02-16', '2026-02-15', 'DELIVERED'),
(212, 112, 1, '2026-02-15', '2026-02-18', '2026-02-18', 'DELIVERED'),

(213, 113, 2, '2026-02-11', '2026-02-15', '2026-02-16', 'DELIVERED'),
(214, 114, 2, '2026-02-12', '2026-02-16', '2026-02-16', 'DELIVERED'),

(215, 115, 1, '2026-02-16', '2026-02-19', '2026-02-19', 'DELIVERED'),
(216, 116, 5, '2026-02-20', '2026-02-24', '2026-02-27', 'DELIVERED'),
(217, 117, 1, '2026-02-21', '2026-02-24', '2026-02-24', 'DELIVERED'),

(218, 118, 3, '2026-02-23', '2026-02-26', '2026-02-26', 'DELIVERED'),
(219, 119, 6, '2026-02-24', '2026-03-01', '2026-03-04', 'DELIVERED'),

(220, 120, 6, '2026-02-25', '2026-03-02', '2026-03-02', 'DELIVERED'),
(221, 121, 3, '2026-02-26', '2026-03-01', '2026-03-03', 'DELIVERED'),

(222, 122, 1, '2026-03-02', '2026-03-05', '2026-03-05', 'DELIVERED'),
(223, 123, 5, '2026-03-03', '2026-03-07', '2026-03-06', 'DELIVERED'),

(224, 124, 5, '2026-03-04', '2026-03-08', '2026-03-10', 'DELIVERED'),
(225, 125, 1, '2026-03-05', '2026-03-08', '2026-03-08', 'DELIVERED'),

(226, 126, 3, '2026-03-06', '2026-03-09', '2026-03-09', 'DELIVERED'),
(227, 127, 6, '2026-03-07', '2026-03-12', '2026-03-15', 'DELIVERED'),

(228, 128, 4, '2026-03-08', '2026-03-13', '2026-03-13', 'DELIVERED'),
(229, 129, 4, '2026-03-09', '2026-03-14', '2026-03-17', 'DELIVERED'),

(230, 130, 8, '2026-03-10', '2026-03-14', '2026-03-14', 'DELIVERED'),
(231, 131, 8, '2026-03-11', '2026-03-15', '2026-03-18', 'DELIVERED'),

(232, 132, 2, '2026-03-12', '2026-03-16', '2026-03-16', 'DELIVERED'),
(233, 133, 7, '2026-03-13', '2026-03-16', '2026-03-17', 'DELIVERED'),

(234, 134, 5, '2026-03-14', '2026-03-18', '2026-03-18', 'DELIVERED'),
(235, 135, 1, '2026-03-15', '2026-03-18', '2026-03-22', 'DELIVERED'),

(236, 136, 3, '2026-03-16', '2026-03-19', '2026-03-19', 'DELIVERED'),
(237, 137, 6, '2026-03-17', '2026-03-22', '2026-03-24', 'DELIVERED'),

(238, 138, 1, '2026-03-18', '2026-03-21', '2026-03-21', 'DELIVERED'),
(239, 139, 5, '2026-03-19', '2026-03-23', '2026-03-26', 'DELIVERED'),
(240, 140, 2, '2026-03-20', '2026-03-24', '2026-03-24', 'DELIVERED');

INSERT INTO Delivery_Tracking
(Tracking_ID, Shipment_ID, Tracking_Date, Location, Tracking_Status)
VALUES
(1, 201, '2026-01-06 09:00:00', 'Chennai', 'PICKED UP'),
(2, 201, '2026-01-07 18:00:00', 'Chennai Hub', 'IN TRANSIT'),
(3, 201, '2026-01-09 11:00:00', 'Chennai', 'DELIVERED'),

(4, 202, '2026-01-19 10:00:00', 'Chennai', 'PICKED UP'),
(5, 202, '2026-01-20 15:00:00', 'Bangalore', 'IN TRANSIT'),
(6, 202, '2026-01-22 12:00:00', 'Bangalore Hub', 'OUT FOR DELIVERY'),
(7, 202, '2026-01-24 14:00:00', 'Bangalore', 'DELIVERED'),

(8, 203, '2026-02-04 09:00:00', 'Bangalore', 'PICKED UP'),
(9, 203, '2026-02-06 13:00:00', 'Bangalore Hub', 'IN TRANSIT'),
(10, 203, '2026-02-07 11:00:00', 'Bangalore', 'DELIVERED'),

(11, 204, '2026-02-05 10:00:00', 'Hyderabad', 'PICKED UP'),
(12, 204, '2026-02-07 16:00:00', 'Hyderabad Hub', 'IN TRANSIT'),
(13, 204, '2026-02-09 10:00:00', 'Hyderabad', 'OUT FOR DELIVERY'),
(14, 204, '2026-02-11 15:00:00', 'Hyderabad', 'DELIVERED'),

(15, 205, '2026-02-15 09:00:00', 'Chennai', 'PICKED UP'),
(16, 205, '2026-02-16 14:00:00', 'Chennai Hub', 'IN TRANSIT'),
(17, 205, '2026-02-18 12:00:00', 'Chennai', 'DELIVERED'),

(18, 206, '2026-02-20 09:00:00', 'Bangalore', 'PICKED UP'),
(19, 206, '2026-02-22 17:00:00', 'Bangalore Hub', 'IN TRANSIT'),
(20, 206, '2026-02-24 11:00:00', 'Chennai Hub', 'OUT FOR DELIVERY'),
(21, 206, '2026-02-26 16:00:00', 'Chennai', 'DELIVERED'),

(22, 207, '2026-01-09 10:00:00', 'Bangalore', 'PICKED UP'),
(23, 207, '2026-01-12 12:00:00', 'Bangalore', 'DELIVERED'),

(24, 208, '2026-01-26 11:00:00', 'Bangalore', 'PICKED UP'),
(25, 208, '2026-01-28 13:00:00', 'Hyderabad', 'IN TRANSIT'),
(26, 208, '2026-01-30 15:00:00', 'Hyderabad', 'OUT FOR DELIVERY'),
(27, 208, '2026-02-02 14:00:00', 'Hyderabad', 'DELIVERED'),

(28, 209, '2026-02-01 09:00:00', 'Hyderabad', 'PICKED UP'),
(29, 209, '2026-02-03 14:00:00', 'Hyderabad Hub', 'IN TRANSIT'),
(30, 209, '2026-02-05 11:00:00', 'Hyderabad', 'DELIVERED'),

(31, 210, '2026-02-11 10:00:00', 'Bangalore', 'PICKED UP'),
(32, 210, '2026-02-13 16:00:00', 'Chennai', 'IN TRANSIT'),
(33, 210, '2026-02-17 15:00:00', 'Chennai', 'DELIVERED'),

(34, 211, '2026-02-12 09:00:00', 'Hyderabad', 'PICKED UP'),
(35, 211, '2026-02-14 14:00:00', 'Hyderabad', 'IN TRANSIT'),
(36, 211, '2026-02-15 12:00:00', 'Hyderabad', 'DELIVERED'),

(37, 212, '2026-02-15 10:00:00', 'Chennai', 'PICKED UP'),
(38, 212, '2026-02-18 13:00:00', 'Chennai', 'DELIVERED'),

(39, 213, '2026-02-11 09:00:00', 'Delhi', 'PICKED UP'),
(40, 213, '2026-02-14 15:00:00', 'Delhi', 'IN TRANSIT'),
(41, 213, '2026-02-16 13:00:00', 'Delhi', 'DELIVERED'),

(42, 214, '2026-02-12 10:00:00', 'Delhi', 'PICKED UP'),
(43, 214, '2026-02-14 16:00:00', 'Delhi', 'IN TRANSIT'),
(44, 214, '2026-02-16 12:00:00', 'Delhi', 'DELIVERED'),

(45, 215, '2026-02-16 09:00:00', 'Chennai', 'PICKED UP'),
(46, 215, '2026-02-19 12:00:00', 'Chennai', 'DELIVERED'),

(47, 216, '2026-02-20 10:00:00', 'Hyderabad', 'PICKED UP'),
(48, 216, '2026-02-23 16:00:00', 'Hyderabad', 'IN TRANSIT'),
(49, 216, '2026-02-27 14:00:00', 'Hyderabad', 'DELIVERED'),

(50, 217, '2026-02-21 09:00:00', 'Chennai', 'PICKED UP'),
(51, 217, '2026-02-23 15:00:00', 'Chennai Hub', 'IN TRANSIT'),
(52, 217, '2026-02-24 11:00:00', 'Chennai', 'DELIVERED'),

(53, 218, '2026-02-23 09:00:00', 'Mumbai', 'PICKED UP'),
(54, 218, '2026-02-26 13:00:00', 'Mumbai', 'DELIVERED'),

(55, 219, '2026-02-24 09:00:00', 'Pune', 'PICKED UP'),
(56, 219, '2026-02-27 15:00:00', 'Pune', 'IN TRANSIT'),
(57, 219, '2026-03-04 16:00:00', 'Pune', 'DELIVERED'),

(58, 220, '2026-02-25 09:00:00', 'Pune', 'PICKED UP'),
(59, 220, '2026-03-02 14:00:00', 'Pune', 'DELIVERED'),

(60, 221, '2026-02-26 10:00:00', 'Mumbai', 'PICKED UP'),
(61, 221, '2026-02-28 15:00:00', 'Mumbai', 'IN TRANSIT'),
(62, 221, '2026-03-03 14:00:00', 'Mumbai', 'DELIVERED'),

(63, 222, '2026-03-02 09:00:00', 'Chennai', 'PICKED UP'),
(64, 222, '2026-03-05 11:00:00', 'Chennai', 'DELIVERED'),

(65, 223, '2026-03-03 10:00:00', 'Bangalore', 'PICKED UP'),
(66, 223, '2026-03-06 13:00:00', 'Bangalore', 'DELIVERED'),

(67, 224, '2026-03-04 09:00:00', 'Hyderabad', 'PICKED UP'),
(68, 224, '2026-03-07 16:00:00', 'Hyderabad', 'IN TRANSIT'),
(69, 224, '2026-03-10 15:00:00', 'Hyderabad', 'DELIVERED'),

(70, 225, '2026-03-05 09:00:00', 'Chennai', 'PICKED UP'),
(71, 225, '2026-03-08 12:00:00', 'Chennai', 'DELIVERED'),

(72, 226, '2026-03-06 10:00:00', 'Mumbai', 'PICKED UP'),
(73, 226, '2026-03-09 13:00:00', 'Mumbai', 'DELIVERED'),

(74, 227, '2026-03-07 09:00:00', 'Pune', 'PICKED UP'),
(75, 227, '2026-03-10 14:00:00', 'Pune', 'IN TRANSIT'),
(76, 227, '2026-03-15 15:00:00', 'Pune', 'DELIVERED'),

(77, 228, '2026-03-08 10:00:00', 'Kolkata', 'PICKED UP'),
(78, 228, '2026-03-11 16:00:00', 'Kolkata', 'IN TRANSIT'),
(79, 228, '2026-03-13 13:00:00', 'Kolkata', 'DELIVERED'),

(80, 229, '2026-03-09 09:00:00', 'Kolkata', 'PICKED UP'),
(81, 229, '2026-03-12 15:00:00', 'Kolkata', 'IN TRANSIT'),
(82, 229, '2026-03-17 16:00:00', 'Kolkata', 'DELIVERED'),

(83, 230, '2026-03-10 10:00:00', 'Kolkata', 'PICKED UP'),
(84, 230, '2026-03-14 13:00:00', 'Kolkata', 'DELIVERED'),

(85, 231, '2026-03-11 09:00:00', 'Kolkata', 'PICKED UP'),
(86, 231, '2026-03-13 16:00:00', 'Kolkata', 'IN TRANSIT'),
(87, 231, '2026-03-18 15:00:00', 'Kolkata', 'DELIVERED'),

(88, 232, '2026-03-12 10:00:00', 'Delhi', 'PICKED UP'),
(89, 232, '2026-03-16 12:00:00', 'Delhi', 'DELIVERED'),

(90, 233, '2026-03-13 09:00:00', 'Jaipur', 'PICKED UP'),
(91, 233, '2026-03-15 15:00:00', 'Jaipur', 'IN TRANSIT'),
(92, 233, '2026-03-17 13:00:00', 'Jaipur', 'DELIVERED'),

(93, 234, '2026-03-14 09:00:00', 'Hyderabad', 'PICKED UP'),
(94, 234, '2026-03-17 16:00:00', 'Hyderabad', 'IN TRANSIT'),
(95, 234, '2026-03-18 14:00:00', 'Hyderabad', 'DELIVERED'),

(96, 235, '2026-03-15 10:00:00', 'Chennai', 'PICKED UP'),
(97, 235, '2026-03-18 15:00:00', 'Chennai', 'IN TRANSIT'),
(98, 235, '2026-03-20 16:00:00', 'Chennai', 'OUT FOR DELIVERY'),
(99, 235, '2026-03-22 14:00:00', 'Chennai', 'DELIVERED'),

(100, 236, '2026-03-16 09:00:00', 'Mumbai', 'PICKED UP'),
(101, 236, '2026-03-19 13:00:00', 'Mumbai', 'DELIVERED'),

(102, 237, '2026-03-17 09:00:00', 'Pune', 'PICKED UP'),
(103, 237, '2026-03-20 15:00:00', 'Pune', 'IN TRANSIT'),
(104, 237, '2026-03-24 14:00:00', 'Pune', 'DELIVERED'),

(105, 238, '2026-03-18 10:00:00', 'Chennai', 'PICKED UP'),
(106, 238, '2026-03-21 13:00:00', 'Chennai', 'DELIVERED'),

(107, 239, '2026-03-19 09:00:00', 'Bangalore', 'PICKED UP'),
(108, 239, '2026-03-22 15:00:00', 'Bangalore', 'IN TRANSIT'),
(109, 239, '2026-03-26 16:00:00', 'Bangalore', 'DELIVERED'),

(110, 240, '2026-03-20 10:00:00', 'Delhi', 'PICKED UP'),
(111, 240, '2026-03-23 14:00:00', 'Delhi', 'IN TRANSIT'),
(112, 240, '2026-03-24 13:00:00', 'Delhi', 'DELIVERED');

INSERT INTO Returns
(Return_ID, Order_ID, Product_ID, Return_Date, Return_Quantity, Return_Reason)
VALUES
(1, 102, 3, '2026-01-28', 1, 'Damaged Product'),
(2, 104, 7, '2026-02-15', 1, 'Product Defect'),
(3, 108, 3, '2026-02-05', 2, 'Wrong Product'),
(4, 110, 1, '2026-02-20', 1, 'Damaged Product'),
(5, 114, 1, '2026-02-20', 1, 'Customer Changed Mind'),
(6, 117, 4, '2026-02-28', 1, 'Product Defect'),
(7, 118, 2, '2026-03-01', 1, 'Wrong Product'),
(8, 121, 2, '2026-03-06', 1, 'Damaged Product'),
(9, 122, 1, '2026-03-10', 1, 'Product Defect'),
(10, 126, 8, '2026-03-15', 1, 'Damaged Product'),
(11, 129, 6, '2026-03-20', 1, 'Product Defect'),
(12, 132, 1, '2026-03-22', 1, 'Wrong Product'),
(13, 134, 4, '2026-03-25', 2, 'Damaged Product'),
(14, 135, 1, '2026-03-27', 1, 'Product Defect'),
(15, 138, 1, '2026-03-28', 1, 'Customer Changed Mind'),
(16, 139, 3, '2026-03-29', 1, 'Damaged Product');
