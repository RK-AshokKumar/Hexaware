-- TASK 1

-- 1.Create the database named "TechShop".
CREATE DATABASE TechShop;

-- 2.Create Tables
Create table Customers (CustomerID int primary key,FirstName varchar(20),LastName varchar(20),Email varchar(30),Phone varchar(20),Address varchar(50));

Create table Products (ProductID int primary key,ProductName varchar(20),Description varchar(50),Price int);

Create table Orders (OrderID int primary key,CustomerID int references Customers(CustomerID),OrderDate date,TotalAmount int);

Create table OrderDetails (OrderDetailID int primary key,OrderID int references Orders(OrderID),ProductID int references Products(ProductID),Quantity int);

Create table Inventory (InventoryID int primary key,ProductID int references Products(ProductID),QuantityInStock int,LastStockUpdate date);

ALTER TABLE Orders
ADD Status VARCHAR(30);

-- Create Table Category
Create table Category (CategoryID int primary key,CategoryName varchar(30));

-- Add the CategoryID column to the Products table
Alter table Products
alter column CategoryID int references Category(CategoryID);

ALTER TABLE Products
ADD COLUMN CategoryID INT;

ALTER TABLE Products ADD CONSTRAINT FK_Products_CategoryID FOREIGN KEY (CategoryID)REFERENCES Category(CategoryID);

-- Insert Values into table Customers
INSERT INTO Customers  VALUES
(1, 'Ashok', 'Kumar', 'ashok@gmail.com', '9877362210', '1st St, Kochi'),
(2, 'Arun', 'Kumar', 'arun@gmail.com', '8347387983', '2nd St, Chennai'),
(3, 'Abi', 'Shek', 'abi@gmail.com', '8374983498', '3rd St, Bengalore'),
(4, 'Ashwin', 'siva', 'ashwin@gmail.com', '2387324982', '4th St, Noida'),
(5, 'Barath', 'Kumar', 'barath@gmail.com', '8458649834', '5th North St, Kolkata'),
(6, 'Raja', 'ram', 'raja@gmail.com', '9837498349', '6th St, Jaipur'),
(7, 'Ram', 'Kishore', 'kishore@gmail.com', '9485790938', '7th St, Hyderabad'),
(8, 'Kirthik', 'Raja', 'Kirthik@gmail.com', '9349759823', '8th St, Mohali'),
(9, 'Gokul', 'Kumar', 'gokul@gmail.com', '6387487237', '9th St, Visakapattinam'),
(10, 'vishnu', 'Prasanth', 'vishnu@gmail.com', '9458745877', '10th St, Bengalore');

Select * from Customers;
-- Insert Values into table Products
INSERT INTO Products (ProductID, ProductName, Description, Price) VALUES
(1, 'Mobile', 'Android 13', 15000),
(2, 'Laptop', '2024 Realeased', 80000),
(3, 'Power Bank', Null, 500),
(4, 'Pc', '2023 Realeased', 50000),
(5, 'Printer', 'Epson', 20000),
(6, 'Charger', '5-min fast charger', 1500),
(7, 'Smartwarch', '2-year warrenty', 4000),
(8, 'Speaker', 'Best Sound quality', 2500),
(9, 'Headphone', 'Ear comfortable', 1000),
(10, 'Mouse', null , 300);


DELETE FROM OrderDetails;

-- Insert Values into table Orders
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount, Status) VALUES
(100, 1, '2024-04-01', 75000, 'Pending'),
(101, 2, '2024-04-02', 320000, 'Shipped'),
(102, 3, '2024-04-03', 1500, 'Pending'),
(103, 4, '2024-04-04', 100000, 'Shipped'),
(104, 5, '2024-04-05', 20000, 'Pending'),
(105, 6, '2024-04-06', 1500, 'Shipped'),
(106, 7, '2024-04-07', 8000, 'Pending'),
(107, 8, '2024-04-08', 7500, 'Shipped'),
(108, 9, '2024-04-09', 4000, 'Pending'),
(109, 10, '2024-04-10', 1500, 'Shipped');

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount, Status) VALUES
(110, 2, '2024-04-05', 100, 'Shipped');

-- Insert Values into table OrderDetails
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity) VALUES
(200, 100, 1, 5),
(201, 101, 2, 4),
(202, 102, 3, 3),
(203, 103, 4, 2),
(204, 104, 5, 1),
(205, 105, 6, 1),
(206, 106, 7, 2),
(207, 107, 8, 3),
(208, 108, 9, 4),
(209, 109, 10,5);

-- Insert Values into table Inventory
INSERT INTO Inventory (InventoryID, ProductID, QuantityInStock, LastStockUpdate) VALUES
(300, 1, 20, '2024-04-01'),
(301, 2, 15, '2024-04-02'),
(302, 3, 10, '2024-04-03'),
(303, 4, 5, '2024-04-04'),
(304, 5, 30, '2024-04-05'),
(305, 6, 8, '2024-04-06'),
(306, 7, 12, '2024-04-07'),
(307, 8, 18, '2024-04-08'),
(308, 9, 25, '2024-04-09'),
(309, 10, 7, '2024-04-10');

INSERT INTO Category (CategoryID, CategoryName) VALUES
(1, 'Mobile'),
(2, 'Laptop'),
(3, 'Power Bank'),
(4, 'Pc'),
(5, 'Printer'),
(6, 'Charger'),
(7,'Smartwarch'),
(8, 'Speakers'),
(9, 'Headphone'),
(10, 'Mouse');


-- SELECT all the rows
SELECT * FROM OrderDetails;

--TASK 2

--1. Write an SQL query to retrieve the names and emails of all customers.

SELECT CONCAT(FirstName,'' ,LastName) AS Name , Email FROM Customers;

--2. Write an SQL query to list all orders with their order dates and corresponding customer names.

SELECT O.OrderID, O.OrderDate, CONCAT(C.FirstName, ' ', C.LastName) AS Name FROM Orders O, Customers C WHERE O.CustomerID = C.CustomerID;

--3. Write an SQL query to insert a new customer record into the "Customers" table. Include 
--customer information such as name, email, and address.

INSERT INTO Customers  VALUES
(11, 'Faazi', 'Meeran', 'faaiz@gmail.com', '9823672362', '1st St, Maharastra');

--4. Write an SQL query to update the prices of all electronic gadgets in the "Products" table by
--increasing them by 10%.

UPDATE Products SET Price = Price * 1.10;

--5. Write an SQL query to delete a specific order and its associated order details from the
--"Orders" and "OrderDetails" tables. Allow users to input the order ID as a parameter.

DECLARE @orderID int;
SET @orderID =105 
DELETE FROM OrderDetails WHERE OrderID = @orderID;
DELETE FROM Orders WHERE OrderID = @orderID;

--6. Write an SQL query to insert a new order into the "Orders" table. Include the customer ID,
--order date, and any other necessary information.

INSERT INTO Orders VALUES(111, 1, '2024-04-03', 600,'Shipped');

--7. Write an SQL query to update the contact information (e.g., email and address) of a specific
--customer in the "Customers" table. Allow users to input the customer ID and new contact information.


DECLARE @CustomerID INT, @NewEmail VARCHAR(30), @NewAddress VARCHAR(50);
SET @CustomerID = 5;
SET @NewEmail = 'barathkumar@gmail.com';
SET @NewAddress = '5th st, Noida';

UPDATE Customers SET Email = @NewEmail, Address = @NewAddress WHERE CustomerID = @CustomerID;

SELECT * FROM Customers;

--8. Write an SQL query to recalculate and update the total cost of each order in the "Orders"
--table based on the prices and quantities in the "OrderDetails" table.

UPDATE Orders SET TotalAmount = (SELECT SUM(Price*Quantity) FROM OrderDetails O JOIN Products P ON O.ProductID=P.ProductID);

SELECT * FROM Orders;


--9. Write an SQL query to delete all orders and their associated order details for a specific
--customer from the "Orders" and "OrderDetails" tables. Allow users to input the customer ID as a parameter.

DECLARE @CustomerID INT;
SET @CustomerID = 2;

DELETE FROM OrderDetails WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = @CustomerID);
DELETE FROM Orders WHERE CustomerID = @CustomerID;


--10. Write an SQL query to insert a new electronic gadget product into the "Products" table,
--including product name, category, price, and any other relevant details.

INSERT INTO Products VALUES (11, 'Printer', 'Clear print', 5000,5);
 
--11. Write an SQL query to update the status of a specific order in the "Orders" table (e.g., from
-- "Pending" to "Shipped"). Allow users to input the order ID and the new status.


DECLARE @OrderID INT, @NewStatus VARCHAR(20);
SET @OrderID = 104
SET @NewStatus =' Shipped'

UPDATE Orders SET Status = @NewStatus WHERE OrderID = @OrderID;

-- 12. Write an SQL query to calculate and update the number of orders placed by each customer
--in the "Customers" table based on the data in the "Orders" table.
ALTER TABLE Customers ADD TotalOrders INT;

UPDATE Customers  SET TotalOrders = (SELECT COUNT(OrderID) FROM Orders O WHERE O.CustomerID = Customers.CustomerID);

SELECT * FROM Customers;

-- Task 3

-- 1. Write an SQL query to find out which customers have not placed any orders.

SELECT CONCAT(C.FirstName,'', C.LastName) AS CustomerName, C.Email FROM Customers C LEFT JOIN  Orders O ON C.CustomerID = O.CustomerID WHERE O.CustomerID IS NULL;

--2. Write an SQL query to find the total revenue generated by each electronic gadget product.
--Include the product name and the total revenue.

SELECT P.ProductName , SUM(P.Price*O.Quantity) AS TotalRevenue FROM Products P INNER JOIN OrderDetails O ON P.ProductID = O.ProductID GROUP BY P.ProductName;

--3. Write an SQL query to list all customers who have made at least one purchase. Include their
--names and contact information.

SELECT CONCAT(C.FirstName,'', C.LastName) AS CustomerName, C.Email, C.Phone FROM Customers C INNER JOIN Orders O ON C.CustomerID = O.CustomerID;

--4. Write an SQL query to find the most popular electronic gadget, which is the one with the highest
-- total quantity ordered. Include the product name and the total quantity ordered.

SELECT TOP 1 P.ProductName, O.Quantity AS TotalQuantityOrdered FROM Products P LEFT JOIN OrderDetails O ON P.ProductID = O.ProductID ORDER BY O.Quantity DESC;

--5. Write an SQL query to retrieve a list of electronic gadgets along with their corresponding
--categories
UPDATE Products
SET CategoryID = 
    CASE 
        WHEN ProductID IN (1, 9) THEN 1  
        WHEN ProductID IN (2, 3) THEN 2  
        WHEN ProductID IN (4, 5) THEN 3  
        WHEN ProductID = 6 THEN 4       
        WHEN ProductID = 7 THEN 5        
        WHEN ProductID = 8 THEN 6    
        WHEN ProductID = 10 THEN 7       
        ELSE NULL 
    END;
SELECT p.ProductName, p.Description, p.Price, c.CategoryName FROM Products p JOIN Category c ON p.CategoryID = c.CategoryID WHERE p.ProductName IN ('Laptop', 'Smartphone', 'Tablet', 'Smartwatch', 'Headphones');

--6. Write an SQL query to calculate the average order value for each customer. Include the
-- customer's name and their average order value.

SELECT CONCAT(C.FirstName,'', C.LastName) AS CustomerName, AVG(O.TotalAmount) AS Average_Order_Value FROM Customers C JOIN Orders O ON C.CustomerID = O.CustomerID GROUP BY C.CustomerID, C.FirstName,C.LastName;

--7. Write an SQL query to find the order with the highest total revenue. Include the order ID,
--customer information, and the total revenue.

SELECT  TOP 1 O.OrderID,C.FirstName , C.LastName, SUM(P.Price*OD.Quantity) AS TotalRevenue FROM Orders O INNER JOIN OrderDetails OD ON  O.OrderID=OD.OrderID INNER JOIN Customers C ON  O.CustomerID=C.CustomerID INNER JOIN Products P ON P.ProductID = OD.ProductID GROUP BY O.OrderID,C.FirstName , C.LastName ORDER BY TotalRevenue DESC;

--8.Write an SQL query to list electronic gadgets and the number of times each product has been
--ordered.

SELECT P.ProductName ,COUNT(O.OrderID) AS Number_of_time_ordered FROM Products P LEFT JOIN OrderDetails O ON P.ProductID = O.ProductID GROUP BY P.ProductName;

--9. Write an SQL query to find customers who have purchased a specific electronic gadget product.
--Allow users to input the product name as a parameter.

DECLARE @ProductName VARCHAR(30);
SET @ProductName = 'Printer';

SELECT DISTINCT CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName FROM Customers C JOIN Orders O ON C.CustomerID = O.CustomerID JOIN OrderDetails OD ON O.OrderID = OD.OrderID JOIN Products P ON OD.ProductID = P.ProductID WHERE P.ProductName = @ProductName;

--10. Write an SQL query to calculate the total revenue generated by all orders placed within a
--specific time period. Allow users to input the start and end dates as parameters.

SELECT SUM(TotalAmount) AS TotalRevenue FROM Orders WHERE OrderDate BETWEEN '2024-04-01' AND '2024-04-07';


-- Task 4. Subquery and its type:

-- 1. Write an SQL query to find out which customers have not placed any orders.

SELECT  CustomerID  ,FirstName, LastName FROM Customers WHERE CustomerID NOT IN(SELECT CustomerID FROM Orders);

--2. Write an SQL query to find the total number of products available for sale.

SELECT COUNT(*) AS TotalProductsAvailable FROM Products WHERE ProductID IN (SELECT ProductID FROM Inventory);

SELECT * FROM OrderDetails;

-- 3. Write an SQL query to calculate the total revenue generated by TechShop.

SELECT SUM(TotalAmount) AS 'Total Revenue' FROM Orders WHERE OrderID IN (SELECT OrderID FROM OrderDetails);

-- 4. Write an SQL query to calculate the average quantity ordered for products in a specific category.
--Allow users to input the category name as a parameter.

DECLARE @CategoryName VARCHAR(30);
SET @CategoryName ='Power Bank';

SELECT AVG(Quantity) AS 'Average Quantity Ordered'FROM OrderDetails WHERE ProductID IN(SELECT ProductID
FROM Products WHERE CategoryID =(SELECT CategoryID FROM Category WHERE CategoryName=@CategoryName));

--5. Write an SQL query to calculate the total revenue generated by a specific customer. Allow users
--to input the customer ID as a parameter.

DECLARE @custoID INT;
SET @custoID =1;

SELECT SUM(P.Price*OD.Quantity) AS TotalRevenue FROM Products P INNER JOIN OrderDetails OD ON P.ProductID = Od.ProductID WHERE OD.OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = @custoID);

--6. Write an SQL query to find the customers who have placed the most orders. List their names
--and the number of orders they've placed

SELECT TOP 1  CONCAT(FirstName,'',LastName) AS CustomerName, (SELECT COUNT(OrderID) FROM Orders WHERE CustomerID = C.CustomerID) AS TotalOrders FROM Customers C ORDER BY TotalOrders DESC;

--7. Write an SQL query to find the most popular product category, which is the one with the highest
--total quantity ordered across all orders.

SELECT CategoryName  FROM Category WHERE CategoryID = (SELECT TOP 1 P.CategoryID FROM OrderDetails OD JOIN Products P ON OD.ProductID = P.ProductID GROUP BY P.CategoryID ORDER BY SUM(Quantity) DESC);

--8. Write an SQL query to find the customer who has spent the most money (highest total revenue)
--on electronic gadgets. List their name and total spending.

SELECT  TOP 1 CONCAT(FirstName,'',LastName) AS CustomerName, (SELECT SUM(TotalAmount) FROM Orders O WHERE O.CustomerID = C.CustomerID) AS TotalSpending FROM Customers C ORDER BY TotalSpending DESC;

--9. Write an SQL query to calculate the average order value (total revenue divided by the number of
-- orders) for all customers.

SELECT  CONCAT(FirstName,'',LastName) AS CustomerName,(SELECT SUM(TotalAmount) FROM Orders WHERE CustomerID = C.CustomerID) / (SELECT COUNT(OrderID) FROM Orders WHERE CustomerID = C.CustomerID)AS AverageOrderValue FROM Customers C ORDER BY AverageOrderValue;

--10. Write an SQL query to find the total number of orders placed by each customer and list their
--names along with the order count.

SELECT CONCAT(FirstName,'',LastName) AS CustomerName, (SELECT COUNT(OrderID) FROM Orders WHERE CustomerID = C.CustomerID)AS TotalOrders FROM Customers C ORDER BY TotalOrders DESC;


