-- WHERE clause, WHERE-Klausel, WHERE-Bedingung
-- wenn man nur bestimmte Ergebnisse ausgeben möchte

USE Northwind;

/*
Syntax:

SELECT Spalten,...
FROM Tabelle
WHERE Bedingung
ORDER BY Spalte ASC|DESC

*/



/*

WHERE Operatoren =, <, >, <=, >=
				!=, <>  -- darf NICHT diesem Wert entsprechen
				LIKE, IN, BETWEEN


		-- nicht so gut für Performance:
				NOT IN
				NOT LIKE
				NOT BETWEEN

		AND, OR

*/


-- alle, die in Deutschland wohnen
SELECT *
FROM Customers
WHERE Country = 'Germany'


-- alle, die in Deutschland in Berlin wohnen
SELECT *
FROM Customers
WHERE Country = 'Germany'
	AND City = 'Berlin'


-- Frachtkosten unter 76
SELECT Freight
FROM Orders
WHERE Freight > 76

-- Frachtkosten, die NICHT einem bestimmten Wert entsprechen
SELECT Freight
FROM Orders
WHERE Freight != 148.33  -- alle, die NICHT diesen Wert haben

-- Ausgabe ordnen ASC (aufsteigend), DESC (absteigend)
SELECT Freight
FROM Orders
WHERE Freight > 76
ORDER BY Freight DESC -- (vom größten zum kleinsten Wert)



SELECT *
FROM Orders
WHERE ShipRegion IS NOT NULL


-- ******************************************** ÜBUNGEN
-- WHERE Übung 1 - 4
-- 1) Gib nur die Kunden aus, die in Frankreich wohnen.
SELECT *
FROM Customers
WHERE Country = 'France'

-- 2) Gib alle Kunden aus, die in Buenos Aires in Argentinien wohnen.
SELECT *
FROM Customers
WHERE Country = 'Argentina'
	AND City = 'Buenos Aires'

-- 3) Gib alle deutschen und österreichischen Kunden aus.
SELECT *
FROM Customers
WHERE Country = 'Germany'
	OR
	  Country = 'Austria'

-- 4) Gib alle Produkte aus, von denen mehr als 100 vorhanden sind.
SELECT *
FROM Products
WHERE UnitsInStock > 100




-- ************************ BETWEEN, IN ********************************
SELECT Freight
FROM Orders
WHERE Freight >= 100 AND Freight <= 200

-- ODER SO:
SELECT Freight
FROM Orders
WHERE Freight BETWEEN 100 AND 200  -- wie oben, 100 und 200 inklusive

-- alle Bestellungen, die vom Employee 3, 4 und 7 bearbeitet worden sind
SELECT *
FROM Orders
WHERE EmployeeID = 3
		OR EmployeeID = 4
		OR EmployeeID = 7

-- ODER SO:
SELECT *
FROM Orders
WHERE EmployeeID IN(3, 4, 7)



-- ******************************************** ÜBUNGEN
-- WHERE Übungen 5,6
-- 5) Gib alle Produkte aus, deren ProduktID zwischen 10 und 15 (inklusive) liegt.
SELECT *
FROM Products
WHERE ProductID BETWEEN 10 AND 15

-- 6) Gib alle Produkte aus, die vom Anbieter (SupplierID) 2, 7 oder 15 geliefert werden.
SELECT *
FROM Products
WHERE SupplierID IN(2, 7, 15)



	




