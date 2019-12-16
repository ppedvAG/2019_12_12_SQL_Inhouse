-- SUBSELECT - Unterabfragen
USE Northwind;

-- Unterabfrage wie eine Spalte verwenden (darf nur einen Wert haben)

SELECT    'Text'
		, Freight
		, (SELECT TOP 1 Freight FROM Orders) -- das hier steht dann in allen Zeilen ;)
FROM Orders


-- Unterabfrage wie eine Tabelle verwenden (Subselect als Datenquelle)
SELECT *
FROM -- Tabelle?
	(SELECT OrderID, Freight FROM Orders WHERE EmployeeID = 3) t1 -- wenn als Datenquelle verwendet, MUSS dieses																Subselect einen Namen bekommen!
WHERE t1.Freight > 100



-- Unterabfrage in einer WHERE Abfrage unterbringen

SELECT *
FROM Orders
WHERE   -- Bedingung:
		Freight > (SELECT AVG(Freight) FROM Orders)
ORDER BY Freight


-- Letztes Beispiel bei UNION (höchster/niedrigster Frachtkostenwert) lässt sich auch mit Subselect lösen!



-- ******************************************** ÜBUNGEN
-- SUBSELECT Übung 1, 2
-- 1) Gib mittels Subselect alle Kunden aus, die in einem Land wohnen, aus dem auch Bestellungen verschifft werden

SELECT *
FROM Customers
WHERE Country IN(SELECT ShipCountry FROM Orders)


--SELECT *
--FROM Customers
--WHERE Country = 'Germany'


-- 2) Gib alle Bestellungen aus, deren Frachtkosten kleiner sind als der Durchschnitt der Frachtkosten. 
-- a. Optional: In absteigender Reihenfolge geordnet (vom größten zum kleinsten Wert).

SELECT OrderID, Freight
FROM Orders
WHERE Freight < (SELECT AVG(Freight) FROM Orders)
ORDER BY Freight DESC





