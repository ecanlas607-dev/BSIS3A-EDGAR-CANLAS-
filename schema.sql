-- ============================================
-- KAHON / McDonald's Order System Database
-- 5 connected tables: Customers, Products, Orders, OrderItems, Payments
-- ============================================

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;

CREATE TABLE Customers (
  CustomerID TEXT PRIMARY KEY,
  CustomerName TEXT NOT NULL,
  Phone TEXT,
  Email TEXT,
  City TEXT
);

CREATE TABLE Products (
  ProductID TEXT PRIMARY KEY,
  ProductName TEXT NOT NULL,
  Category TEXT,
  UnitPrice REAL NOT NULL
);

CREATE TABLE Orders (
  OrderID TEXT PRIMARY KEY,
  CustomerID TEXT NOT NULL,
  OrderDate TEXT,
  OrderTime TEXT,
  OrderType TEXT,
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderItems (
  OrderItemID TEXT PRIMARY KEY,
  OrderID TEXT NOT NULL,
  ProductID TEXT NOT NULL,
  Quantity INTEGER NOT NULL,
  Subtotal REAL NOT NULL,
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
  FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Payments (
  PaymentID TEXT PRIMARY KEY,
  OrderID TEXT NOT NULL,
  Amount REAL NOT NULL,
  PaymentMethod TEXT,
  PaymentStatus TEXT,
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Data para sa Customers
INSERT INTO Customers (CustomerID, CustomerName, Phone, Email, City) VALUES ('C001', 'John Smith', '09171234567', 'john.smith@email.com', 'Baao');
INSERT INTO Customers (CustomerID, CustomerName, Phone, Email, City) VALUES ('C002', 'Maria Santos', '09181234568', 'maria.santos@email.com', 'Naga');
INSERT INTO Customers (CustomerID, CustomerName, Phone, Email, City) VALUES ('C003', 'Kevin Cruz', '09191234569', 'kevin.cruz@email.com', 'Iriga');
INSERT INTO Customers (CustomerID, CustomerName, Phone, Email, City) VALUES ('C004', 'Angela Reyes', '09201234570', 'angela.reyes@email.com', 'Baao');
INSERT INTO Customers (CustomerID, CustomerName, Phone, Email, City) VALUES ('C005', 'Daniel Garcia', '09211234571', 'daniel.garcia@email.com', 'Naga');
INSERT INTO Customers (CustomerID, CustomerName, Phone, Email, City) VALUES ('C006', 'Sofia Mendoza', '09221234572', 'sofia.mendoza@email.com', 'Baao');
INSERT INTO Customers (CustomerID, CustomerName, Phone, Email, City) VALUES ('C007', 'Mark Villanueva', '09231234573', 'mark.v@email.com', 'Iriga');
INSERT INTO Customers (CustomerID, CustomerName, Phone, Email, City) VALUES ('C008', 'Claire Ramos', '09241234574', 'claire.ramos@email.com', 'Naga');
INSERT INTO Customers (CustomerID, CustomerName, Phone, Email, City) VALUES ('C009', 'Ryan Flores', '09251234575', 'ryan.flores@email.com', 'Baao');
INSERT INTO Customers (CustomerID, CustomerName, Phone, Email, City) VALUES ('C010', 'Ella Navarro', '09261234576', 'ella.navarro@email.com', 'Iriga');

-- Data para sa Products
INSERT INTO Products (ProductID, ProductName, Category, UnitPrice) VALUES ('P001', 'Big Mac', 'Burger', 185);
INSERT INTO Products (ProductID, ProductName, Category, UnitPrice) VALUES ('P002', 'McChicken', 'Burger', 165);
INSERT INTO Products (ProductID, ProductName, Category, UnitPrice) VALUES ('P003', 'Cheeseburger', 'Burger', 95);
INSERT INTO Products (ProductID, ProductName, Category, UnitPrice) VALUES ('P004', 'McSpaghetti', 'Pasta', 120);
INSERT INTO Products (ProductID, ProductName, Category, UnitPrice) VALUES ('P005', 'Chicken McDo', 'Chicken', 135);
INSERT INTO Products (ProductID, ProductName, Category, UnitPrice) VALUES ('P006', 'French Fries', 'Side', 75);
INSERT INTO Products (ProductID, ProductName, Category, UnitPrice) VALUES ('P007', 'McFlurry', 'Dessert', 95);
INSERT INTO Products (ProductID, ProductName, Category, UnitPrice) VALUES ('P008', 'Apple Pie', 'Dessert', 55);
INSERT INTO Products (ProductID, ProductName, Category, UnitPrice) VALUES ('P009', 'Coke', 'Beverage', 60);
INSERT INTO Products (ProductID, ProductName, Category, UnitPrice) VALUES ('P010', 'Iced Coffee', 'Beverage', 85);

-- Data para sa Orders
INSERT INTO Orders (OrderID, CustomerID, OrderDate, OrderTime, OrderType) VALUES ('O001', 'C001', '2026-08-01', '11:15 AM', 'Dine-In');
INSERT INTO Orders (OrderID, CustomerID, OrderDate, OrderTime, OrderType) VALUES ('O002', 'C002', '2026-08-01', '12:05 PM', 'Takeout');
INSERT INTO Orders (OrderID, CustomerID, OrderDate, OrderTime, OrderType) VALUES ('O003', 'C003', '2026-08-02', '01:20 PM', 'Dine-In');
INSERT INTO Orders (OrderID, CustomerID, OrderDate, OrderTime, OrderType) VALUES ('O004', 'C004', '2026-08-02', '05:40 PM', 'Takeout');
INSERT INTO Orders (OrderID, CustomerID, OrderDate, OrderTime, OrderType) VALUES ('O005', 'C005', '2026-08-03', '10:30 AM', 'Drive-Thru');
INSERT INTO Orders (OrderID, CustomerID, OrderDate, OrderTime, OrderType) VALUES ('O006', 'C006', '2026-08-03', '02:15 PM', 'Dine-In');
INSERT INTO Orders (OrderID, CustomerID, OrderDate, OrderTime, OrderType) VALUES ('O007', 'C007', '2026-08-04', '06:10 PM', 'Takeout');
INSERT INTO Orders (OrderID, CustomerID, OrderDate, OrderTime, OrderType) VALUES ('O008', 'C008', '2026-08-05', '09:45 AM', 'Drive-Thru');
INSERT INTO Orders (OrderID, CustomerID, OrderDate, OrderTime, OrderType) VALUES ('O009', 'C009', '2026-08-05', '12:35 PM', 'Dine-In');
INSERT INTO Orders (OrderID, CustomerID, OrderDate, OrderTime, OrderType) VALUES ('O010', 'C010', '2026-08-06', '07:05 PM', 'Takeout');

-- Data para sa OrderItems
INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, Subtotal) VALUES ('OI001', 'O001', 'P001', 1, 185);
INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, Subtotal) VALUES ('OI002', 'O001', 'P006', 1, 75);
INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, Subtotal) VALUES ('OI003', 'O002', 'P005', 2, 270);
INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, Subtotal) VALUES ('OI004', 'O002', 'P009', 2, 120);
INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, Subtotal) VALUES ('OI005', 'O003', 'P004', 1, 120);
INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, Subtotal) VALUES ('OI006', 'O003', 'P007', 1, 95);
INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, Subtotal) VALUES ('OI007', 'O004', 'P002', 1, 165);
INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, Subtotal) VALUES ('OI008', 'O004', 'P006', 1, 75);
INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, Subtotal) VALUES ('OI009', 'O005', 'P003', 2, 190);
INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, Subtotal) VALUES ('OI010', 'O006', 'P010', 1, 85);

-- Data para sa Payments
INSERT INTO Payments (PaymentID, OrderID, Amount, PaymentMethod, PaymentStatus) VALUES ('PAY001', 'O001', 260, 'Cash', 'Paid');
INSERT INTO Payments (PaymentID, OrderID, Amount, PaymentMethod, PaymentStatus) VALUES ('PAY002', 'O002', 390, 'GCash', 'Paid');
INSERT INTO Payments (PaymentID, OrderID, Amount, PaymentMethod, PaymentStatus) VALUES ('PAY003', 'O003', 215, 'Cash', 'Paid');
INSERT INTO Payments (PaymentID, OrderID, Amount, PaymentMethod, PaymentStatus) VALUES ('PAY004', 'O004', 240, 'Card', 'Paid');
INSERT INTO Payments (PaymentID, OrderID, Amount, PaymentMethod, PaymentStatus) VALUES ('PAY005', 'O005', 190, 'Cash', 'Paid');
INSERT INTO Payments (PaymentID, OrderID, Amount, PaymentMethod, PaymentStatus) VALUES ('PAY006', 'O006', 85, 'GCash', 'Paid');
INSERT INTO Payments (PaymentID, OrderID, Amount, PaymentMethod, PaymentStatus) VALUES ('PAY007', 'O007', 240, 'Cash', 'Paid');
INSERT INTO Payments (PaymentID, OrderID, Amount, PaymentMethod, PaymentStatus) VALUES ('PAY008', 'O008', 175, 'Card', 'Paid');
INSERT INTO Payments (PaymentID, OrderID, Amount, PaymentMethod, PaymentStatus) VALUES ('PAY009', 'O009', 305, 'GCash', 'Paid');
INSERT INTO Payments (PaymentID, OrderID, Amount, PaymentMethod, PaymentStatus) VALUES ('PAY010', 'O010', 260, 'Cash', 'Paid');
