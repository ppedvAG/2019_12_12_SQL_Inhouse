-- VIEWS (Sichten)
USE Northwind;

-- Syntax
-- CREATE VIEW vName
-- AS


-- Bsp.:

CREATE VIEW vTest
AS
SELECT CustomerID, CompanyName
FROM Customers

-- kann auch wieder gelöscht werden:
DROP VIEW vTest




CREATE VIEW vCustomerContacts
AS
SELECT	  CustomerID
		, CompanyName
		, ContactName
		, Phone
FROM Customers


SELECT * FROM vCustomerContacts


SELECT *
FROM vCustomerContacts
WHERE CustomerID LIKE '[a-c]%'



CREATE VIEW vCustomerFreight
AS
SELECT	  c.CustomerID
		, CompanyName
		, City
		, ContactName
		, Phone
		, OrderID
		, Freight
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID



SELECT * FROM vCustomerFreight



CREATE VIEW vCustomersGermany
AS
SELECT	  c.CustomerID
		, CompanyName
		, City
		, ContactName
		, Phone
		, OrderID
		, Freight
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE Country = 'Germany'


SELECT *
FROM vCustomersGermany
WHERE Freight < 55
ORDER BY Freight, CustomerID



-- ******************************************** ÜBUNG
-- VIEW Übung 1
/*
1)
Erstelle eine VIEW: Welche Kunden haben welche Produkte gekauft? 
OrderID, CompanyName, ProductName, Quantity sollen ausgegeben werden. 
Optional: Gib eine zusätzliche Spalte aus, in der steht, wieviel die jeweiligen Rechnungsposten gekostet haben. 

*/


CREATE VIEW vKundenbestellungen
AS
SELECT	  o.OrderID
		, c.CompanyName
		, p.ProductName
		, od.Quantity
		, SUM(od.UnitPrice*od.Quantity) AS Rechnungssumme
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
				 INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
				 INNER JOIN Products p ON p.ProductID = od.ProductID
GROUP BY o.OrderID, c.CompanyName, p.ProductName, od.Quantity


SELECT * FROM vKundenbestellungen




