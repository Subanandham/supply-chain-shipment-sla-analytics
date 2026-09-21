Customers
Products
Warehouses
Orders
Order_Details
Carriers
Shipments
Delivery_Tracking
Returns

create table Customers (
	customer_ID int primary key auto_increment,
    Customer_Name varchar(100) not null,
    Email varchar(200) not null unique,
    phone varchar(15) unique,
    Region varchar(50) not null,
    City varchar(50),
    Created_date date default ( current_date)
);

CREATE TABLE Products (
    Product_ID INT PRIMARY KEY AUTO_INCREMENT,
    Product_Name VARCHAR(100) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Unit_Price DECIMAL(10,2) NOT NULL,
    Weight_KG DECIMAL(8,2),
    Returnable CHAR(1) DEFAULT 'Y',
    
    CHECK (Unit_Price > 0),
    CHECK (Weight_KG >= 0),
    CHECK (Returnable IN ('Y', 'N'))
);

CREATE TABLE Warehouses (
    Warehouse_ID INT PRIMARY KEY AUTO_INCREMENT,
    Warehouse_Name VARCHAR(100) NOT NULL,
    Region VARCHAR(50) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Capacity INT NOT NULL,
    
    CHECK (Capacity > 0)
);

CREATE TABLE Carriers (
    Carrier_ID INT PRIMARY KEY AUTO_INCREMENT,
    Carrier_Name VARCHAR(100) NOT NULL UNIQUE,
    Region VARCHAR(50) NOT NULL,
    Contact_Number VARCHAR(15),
    SLA_Days INT NOT NULL,
    
    CHECK (SLA_Days > 0)
);

CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY AUTO_INCREMENT,
    Customer_ID INT NOT NULL,
    Warehouse_ID INT NOT NULL,
    Order_Date DATE NOT NULL,
    Order_Status VARCHAR(30) DEFAULT 'PLACED',
    Order_Value DECIMAL(12,2) NOT NULL,

    CHECK (Order_Value > 0),
    CHECK (Order_Status IN ('PLACED', 'PROCESSING', 'SHIPPED', 'DELIVERED', 'CANCELLED')),

    FOREIGN KEY (Customer_ID) 
        REFERENCES Customers(Customer_ID),

    FOREIGN KEY (Warehouse_ID) 
        REFERENCES Warehouses(Warehouse_ID)
);

CREATE TABLE Order_Details (
    Order_Detail_ID INT PRIMARY KEY AUTO_INCREMENT,
    Order_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    Quantity INT NOT NULL,
    Unit_Price DECIMAL(10,2) NOT NULL,

    CHECK (Quantity > 0),
    CHECK (Unit_Price > 0),

    FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID),

    FOREIGN KEY (Product_ID)
        REFERENCES Products(Product_ID)
);

CREATE TABLE Shipments (
    Shipment_ID INT PRIMARY KEY AUTO_INCREMENT,
    Order_ID INT NOT NULL UNIQUE,
    Carrier_ID INT NOT NULL,
    Shipment_Date DATE NOT NULL,
    Expected_Delivery DATE NOT NULL,
    Actual_Delivery DATE,
    Shipment_Status VARCHAR(30) DEFAULT 'IN TRANSIT',

    CHECK (Shipment_Status IN ('IN TRANSIT', 'DELIVERED', 'CANCELLED')),

    FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID),

    FOREIGN KEY (Carrier_ID)
        REFERENCES Carriers(Carrier_ID)
);

CREATE TABLE Delivery_Tracking (
    Tracking_ID INT PRIMARY KEY AUTO_INCREMENT,
    Shipment_ID INT NOT NULL,
    Tracking_Date DATETIME NOT NULL,
    Location VARCHAR(100),
    Tracking_Status VARCHAR(50) NOT NULL,

    FOREIGN KEY (Shipment_ID)
        REFERENCES Shipments(Shipment_ID)
);

CREATE TABLE Returns (
    Return_ID INT PRIMARY KEY AUTO_INCREMENT,
    Order_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    Return_Date DATE NOT NULL,
    Return_Quantity INT NOT NULL,
    Return_Reason VARCHAR(100),

    CHECK (Return_Quantity > 0),

    FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID),

    FOREIGN KEY (Product_ID)
        REFERENCES Products(Product_ID)
);

SHOW TABLES;