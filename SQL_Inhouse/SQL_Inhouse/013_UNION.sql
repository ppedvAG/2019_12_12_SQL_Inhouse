-- UNION

USE Northwind;

-- bisher: Ergebnis eine neue Tabelle mit entsprechend mehr Spalten

-- Datentypen und Spaltenanzahl müssen übereinstimmen

SELECT	  CompanyName
		, OrderID
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID


SELECT 'Testtext1' AS Test
UNION
SELECT 'Testtext2' -- AS Test (reicht oben, kann ich aber dazuschreiben)

-- Liste von allen Kontaktpersonen
-- Customers und Suppliers
-- CustomerID, CompanyName, ContactName, Phone
-- SupplierID, CompanyName, ContactName, Phone


-- NEIN!!!:
SELECT c.CustomerID, c.CompanyName, c.ContactName, c.Phone,
	   s.SupplierID, s.CompanyName, s.ContactName, s.Phone
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
				 INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
				 INNER JOIN Products p ON p.ProductID = od.ProductID
				 INNER JOIN Suppliers s ON s.SupplierID = p.SupplierID
-- (damit bekommen wir keine Liste, sondern entsprechend mehr Spalten)




-- hier stimmen die Datentypen überein, das geht:
SELECT CompanyName, ContactName, Phone
FROM Customers
UNION
SELECT CompanyName, ContactName, Phone
FROM Suppliers


-- geht NICHT, weil die gleiche Anzahl an Spalten abgefragt werden muss
SELECT CompanyName, Phone
FROM Customers
UNION
SELECT HomePhone
FROM Employees


-- geht NICHT, weil gleicher Datentyp vorhanden sein muss (CompanyName und EmployeeID sind unterschiedliche Datentypen)
SELECT CompanyName, Phone
FROM Customers
UNION
SELECT EmployeeID, HomePhone
FROM Employees


-- geht NICHT: Struktur muss passen
SELECT EmployeeID, HomePhone
FROM Employees
UNION
SELECT Phone, SupplierID
FROM Suppliers


-- geht, weil gleiche Datentypen und gleiche Spaltenanzahl
SELECT Country, Phone
FROM Customers
UNION
SELECT Country, HomePhone
FROM Employees



-- ******************************************** ÜBUNGEN
-- UNION Übung 1, 2
/*
1)
Gib den Firmennamen, die Kontaktperson und die Telefonnummern aller Kunden und aller Supplier in 
einer Liste aus. 
a. Optional: Füge eine Kategorie „C“ für Customer und „S“ für Supplier hinzu.

*/

-- Wie ging noch mal Text einfügen?
-- SELECT 'Testtext' AS Test

SELECT CompanyName, ContactName, Phone, 'C' AS Category
FROM Customers
UNION
SELECT CompanyName, ContactName, Phone, 'S' -- AS Category
FROM Suppliers

/*
2) Gib alle Regionen der Kunden und der Angestellten aus.
a.	Optional: Füge eine Kategorie „C“ für Customer und „E“ für Employee hinzu.
*/
SELECT Region, 'C' AS Category
FROM Customers
UNION
SELECT Region, 'E' AS Category
FROM Employees





-- möglich, aber... SINN?
SELECT Phone, CompanyName
FROM Customers
UNION
SELECT HomePhone, 'Blabla'
FROM Employees


-- ich darf NULL reinschreiben... SINN??
SELECT Phone, CompanyName
FROM Customers
UNION
SELECT HomePhone, NULL
FROM Employees


-- UNION macht auch ein DISTINCT
SELECT 'Testtext'
UNION
SELECT 'Testtext'


-- wenn ich kein DISTINCT möchte: UNION ALL
SELECT 'Testtext'
UNION ALL
SELECT 'Testtext'



-- höchste Frachtkosten und niedrigste Frachtkosten in Liste?
-- geht NICHT:
SELECT TOP 1 OrderID, Freight, 'niedrigster Wert'
FROM Orders
ORDER BY Freight -- dieses ORDER BY funktioniert nicht!
UNION
SELECT TOP 1 OrderID, Freight, 'höchster Wert'
FROM Orders
ORDER BY Freight DESC -- das letzte ORDER BY gilt für die ganze Abfrage!!


-- mit temporärer Tabelle funktioniert es:
SELECT TOP 1 OrderID, Freight, 'niedrigster Wert' AS Wert
INTO #niedrigsterWert
FROM Orders
ORDER BY Freight ASC

SELECT TOP 1 OrderID, Freight, 'höchster Wert' AS Wert
INTO #hoechsterWert
FROM Orders
ORDER BY Freight DESC


SELECT *
FROM #niedrigsterWert
UNION
SELECT *
FROM #hoechsterWert


-- oder mit SUBSELECT gehts auch:

--SELECT TOP 1 OrderID, Freight, 'niedrigster Wert'
--FROM Orders
--ORDER BY Freight

SELECT *
FROM
	(SELECT TOP 1 OrderID, Freight, 'niedrigster Wert' AS Wert FROM Orders ORDER BY Freight ASC) n
UNION
SELECT *
FROM
	(SELECT TOP 1 OrderID, Freight, 'höchster Wert' AS Wert FROM Orders ORDER BY Freight DESC) h




-- NEIN!! FAAALSCH!! so funktionierts NICHT:
SELECT TOP 1 OrderID, MIN(Freight) AS Freight
FROM Orders
GROUP BY OrderID, Freight
ORDER BY Freight
UNION
SELECT TOP 1 OrderID, MAX(Freight) AS Freight
FROM Orders
GROUP BY OrderID, Freight
ORDER BY Freight
-- mit min/max etwas komplizierter... wieder Problem mit Order By und Group By und Union!


-- so gehts (aber nur für die eine Spalte):
SELECT  MIN(Freight) AS Freight
FROM Orders
UNION
SELECT MAX(Freight) AS Freight
FROM Orders





-- höchster/niedrigster Wert mit Subselect:

SELECT *
FROM
	(SELECT TOP 1 OrderID, Freight, 'niedrigster Wert' AS Ranking FROM Orders ORDER BY Freight) n
UNION
SELECT *
FROM
	(SELECT TOP 1 OrderID, Freight, 'höchster Wert' AS Ranking FROM Orders ORDER BY Freight DESC) h