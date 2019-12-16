-- CASE
USE Northwind;

SELECT OrderID, Quantity,
	CASE
		WHEN Quantity > 10 THEN 'größer 10'
		WHEN Quantity = 10 THEN 'genau 10'

		ELSE 'unbekannt'
	END AS Anzahl
FROM [Order Details]


-- Übung:  
-- von Customers
-- CustomerID, Country... 
-- wenn EU Mitglied, dann 'EU'
-- wenn nicht EU Mitglied, dann 'nicht EU'
-- wenn nicht bekannt, dann 'keine Ahnung'

/*
	SELECT DISTINCT Country
	FROM Customers
	-- 21
*/

SELECT CustomerID, Country,
	CASE
		WHEN Country IN('France', 'Germany', 'Austria', 'Italy') THEN 'EU'
		WHEN Country = 'UK' THEN 'Brexit'
		WHEN Country IN('USA', 'Argentina', 'Brazil') THEN 'nicht EU'
		ELSE 'keine Ahnung'
	END AS Region
FROM Customers


--CASE
--		WHEN Country = 'France' THEN 'EU'
--		WHEN Country = 'Germany' THEN 'EU'
--		WHEN Country = 'UK' THEN 'Brexit'
--		ELSE 'keine Ahnung'
--	END AS Region


SELECT CustomerID, Country,
	CASE
		WHEN Country LIKE 'U%' THEN 'U-Land'
		ELSE 'keine Ahnung'
	END AS Region
FROM Customers
ORDER BY Country




