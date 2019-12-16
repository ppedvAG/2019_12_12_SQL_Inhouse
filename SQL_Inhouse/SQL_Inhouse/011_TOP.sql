-- TOP Abfragen
-- ORDER BY zwingend notwendig!



SELECT *
FROM Customers

-- nur die erste Zeile ausgeben
SELECT TOP 1 *
FROM Customers
-- ... aber was genau ist die erste Zeile? Daher immer mit ORDER BY arbeiten, wenn man TOP verwendet!
SELECT TOP 1 *
FROM Customers
ORDER BY CustomerID


-- SYNTAX:
-- SELECT TOP # [percent] * | [Spaltenname, Spaltenname,...] FROM Tabelle [WHERE Bedingung] ORDER BY Spalte


-- man kann auch die TOP x% abfragen:
SELECT TOP 10 PERCENT *
FROM Customers
ORDER BY CustomerID


SELECT TOP 5 PERCENT 
		  CustomerID
		  , CompanyName
		  , ContactName
		  , Phone
FROM Customers
ORDER BY City


SELECT TOP 10 PERCENT *
FROM Orders
ORDER BY Freight


SELECT TOP 7 *
FROM Customers
ORDER BY CustomerID


-- die letzten 3:
SELECT TOP 3 *
FROM Customers
ORDER BY CustomerID DESC -- Reihenfolge mit DESC umkehren


-- WITH TIES: die Top 1% und alle, die den gleichen Wert haben wie der Letzte in den Top 1%
SELECT TOP 1 PERCENT WITH TIES *
FROM [Order Details]
ORDER BY UnitPrice DESC



-- ******************************************** ÜBUNGEN
-- TOP Übungen 1-3
-- 1)	Gib das teuerste Produkt aus. 

SELECT TOP 1 *
FROM Products
ORDER BY UnitPrice DESC

-- überprüfen:

SELECT *
FROM Products
ORDER BY UnitPrice DESC

/*
2)
Suche die Top 10% der Produkte mit den größten Einkaufsmengen (ProductName, Quantity). 
	a. Optional: Einschließlich Produkte mit der gleichen Einkaufsmenge wie das letzte in der ursprünglichen Ausgabe. 
*/


SELECT TOP 10 PERCENT WITH TIES ProductName, Quantity
FROM Products p INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
ORDER BY Quantity DESC


-- 3) Gib die drei Mitarbeiter, die als erste eingestellt wurden, aus (die schon am längsten beim Unternehmen sind). 
SELECT TOP 3 *
FROM Employees
ORDER BY HireDate -- ASC (kann ich hinschreiben, kann ich aber auch weglassen, weil ASC = default)



-- 13 Kunden mit den geringsten Frachtkosten bekommen Bonus (Annahme)
-- wer sind die Glücklichen?

SELECT TOP 13 
		  OrderID
		, c.CustomerID
		, Freight
		, CompanyName
FROM Orders o INNER JOIN Customers c ON o.CustomerID = c.CustomerID
ORDER BY Freight

-- was, wenn Nr. 14 die gleichen Frachtkosten hat? --> with Ties
SELECT TOP 13 WITH TIES
		  OrderID
		, c.CustomerID
		, Freight
		, CompanyName
FROM Orders o INNER JOIN Customers c ON o.CustomerID = c.CustomerID
ORDER BY Freight