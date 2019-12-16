-- PROCEDURES
USE Northwind;

-- Syntax
-- CREATE PROC pName
-- AS
-- SELECT ....
-- SELECT ....

-- Bsp.:

CREATE PROC Demo
AS
SELECT TOP 1 * FROM Orders ORDER BY Freight
SELECT TOP 3 Freight FROM Orders WHERE Freight < 30
SELECT Country FROM Customers


-- aufrufen mit EXEC (execute)

EXEC Demo


CREATE PROC pAllCustomers @City varchar(30)
AS
SELECT * FROM Customers WHERE City = @City


EXEC pAllCustomers @City = 'Berlin'


CREATE PROC pCustomers2 @City varchar(30), @Country varchar(30)
AS
SELECT * FROM Customers WHERE City = @City AND Country = @Country



EXEC pCustomers2 @City='Berlin', @Country = 'Germany'



