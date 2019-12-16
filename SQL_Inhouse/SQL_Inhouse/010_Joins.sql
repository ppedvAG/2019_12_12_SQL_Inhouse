-- Tabellen miteinander verknüpfen: JOINS
USE Northwind;



-- INNER JOIN

-- LEFT JOIN
				-- OUTER JOINS
-- RIGHT JOIN


-- INNER JOIN (sind die, die am häufigsten verwendet werden)

SELECT *
FROM Orders INNER JOIN Customers
	ON Orders.CustomerID = Customers.CustomerID


-- wenn ein Spaltenname in mehreren Tabellen vorkommt, muss man festlegen, welchen genau man will:
SELECT	  OrderID
		, Customers.CustomerID -- in diesem Fall egal, es könnte auch Orders.CustomerID hier stehen
		, CompanyName
		, ShippedDate
FROM Orders INNER JOIN Customers
	ON Orders.CustomerID = Customers.CustomerID

-- kürzere Schreibweise
SELECT	  OrderID
		, c.CustomerID
		, CompanyName
		, ShippedDate
FROM Orders o INNER JOIN Customers c
	ON o.CustomerID = c.CustomerID




-- auch hier können wir natürlich mit WHERE einschränken
SELECT	  OrderID
		, Customers.CustomerID
		, CompanyName
		, Freight
		, ShipCountry
FROM Orders INNER JOIN Customers
		ON Orders.CustomerID = Customers.CustomerID
WHERE Country = 'UK'

-- kürzere Schreibweise:
SELECT	  OrderID
		, c.CustomerID
		, CompanyName
		, Freight
		, ShipCountry
FROM Orders o INNER JOIN Customers c
		ON o.CustomerID = c.CustomerID
WHERE Country = 'UK'


-- ich DARF, muss aber nicht, bei allen angeben, aus welcher Tabelle sie kommen
-- wenn Name in mehreren Tabellen vorkommt, also nicht eindeutig ist, MUSS ich Tabelle angeben

SELECT	  o.OrderID
		, c.CustomerID
		, c.CompanyName
		, o.Freight
		, o.ShipCountry
FROM Orders o INNER JOIN Customers c
		ON o.CustomerID = c.CustomerID
WHERE c.Country = 'UK'


-- alle Kunden, die noch nichts bestellt haben?
-- mit RIGHT JOIN:
SELECT	  o.OrderID
		, c.CustomerID
		, c.CompanyName
		, o.Freight
		, o.ShipCountry 
FROM Orders o RIGHT JOIN Customers c
		ON o.CustomerID = c.CustomerID 
WHERE OrderID IS NULL

-- oder LEFT JOIN:
SELECT	  o.OrderID
		, c.CustomerID
		, c.CompanyName
		, o.Freight
		, o.ShipCountry 
FROM Customers c LEFT JOIN Orders o
		ON c.CustomerID = o.CustomerID 
WHERE OrderID IS NULL


-- INNER JOIN: da stehen nur die Kunden drin, die auch etwas bestellt haben
SELECT	  o.OrderID
		, c.CustomerID
		, c.CompanyName
		, o.Freight
		, o.ShipCountry 
FROM Orders o INNER JOIN Customers c
		ON o.CustomerID = c.CustomerID
-- WHERE OrderID IS NULL -- würden wir hier IS NULL abfragen, bekommen wir keine Treffer
ORDER BY c.CustomerID


-- LEFT JOIN 
-- nur die, die auch etwas bestellt haben (Reihenfolge! Was steht beim Join links, was rechts?)
SELECT	  o.OrderID
		, c.CustomerID
		, c.CompanyName
		, o.Freight
		, o.ShipCountry 
FROM Orders o LEFT JOIN Customers c
		ON o.CustomerID = c.CustomerID
ORDER BY c.CustomerID


-- RIGHT JOIN (hier: auch die, die noch nichts bestellt haben)
SELECT	  o.OrderID
		, c.CustomerID
		, c.CompanyName
		, o.Freight
		, o.ShipCountry 
FROM Orders o RIGHT JOIN Customers c
		ON o.CustomerID = c.CustomerID
ORDER BY c.CustomerID


-- alle Kunden aus den USA und aus den UK und ihre Frachtkosten
-- CustomerID, CompanyName, Country, Freight
-- geordnet nach Land

SELECT	  c.CustomerID
		, CompanyName
		, Country
		, Freight
FROM Customers c INNER JOIN Orders o
		ON c.CustomerID = o.CustomerID
WHERE Country = 'UK' OR Country = 'USA'
ORDER BY Country, c.CustomerID -- mehrere möglich; aufsteigend/absteigend unterschiedlich möglich



-- Bestellnummer, Employee Name, CompanyName
SELECT	  OrderID
		, LastName
		, c.CustomerID
		, CompanyName
FROM Orders o INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
			  INNER JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE e.EmployeeID IN(3, 4, 7)



-- ******************************************** ÜBUNGEN
-- INNER JOIN Übung 1 - 4
-- 1) Gib den Namen des Anbieters, der Chai Tee verkauft, aus. (CompanyName, ProductName; optional: Ansprechperson, Telefonnummer)
SELECT	 CompanyName
		, ProductName
		, ContactName
		, Phone
FROM Suppliers s INNER JOIN Products p ON s.SupplierID = p.SupplierID
WHERE ProductName LIKE '%chai%'

-- kurzer Blick in alle Produkte, ob das so stimmen kann (und wie der Chai Tee hier tatsächlich heißt):
SELECT *
FROM Products

-- 2) Welche Kunden haben Chai Tee gekauft und wieviel? (OrderID, CompanyName, ProductName, Quantity)
SELECT	  CompanyName
		, o.OrderID
		, Quantity
		, ProductName
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
				 INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
				 INNER JOIN Products p ON p.ProductID = od.ProductID
WHERE ProductName LIKE '%chai%'


-- 3) Gib alle Kunden aus den USA und deren Frachtkosten aus.

SELECT	  CompanyName
		, Country
		, Freight
FROM Orders o INNER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE Country = 'USA'
ORDER BY CompanyName, Freight


/*
-- 4) Suche alle Bestellungen, bei denen Bier verkauft wurde. Welcher Kunde? Wieviel? Welches Bier? (Der 
Produktname kann „Bier“ oder „Lager“ enthalten oder mit „Ale“ enden.)  
a. Optional: Nach Menge und Kundenname geordnet. 
b. Optional: Menge absteigend (größte zuerst), Kundenname aufsteigend (A-Z) 
*/

SELECT	  CompanyName
		, Quantity
		, ProductName
		, c.ContactName
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
				 INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
				 INNER JOIN Products p ON p.ProductID = od.ProductID
WHERE ProductName LIKE '%bier%'
		OR ProductName LIKE '%lager%'
		OR ProductName LIKE '%ale'
ORDER BY Quantity DESC, CompanyName



/*
Syntax für das Joinen von mehreren Tabellen

SELECT Spalte, Spalte,...
FROM
	tab1 INNER JOIN tab2 ON tab1.spalteX = tab2.spalteX
		 INNER JOIN tab3 ON tab3.spalteY = tab2.spalteY (oder tab1.spalteY - womit verknüpft werden soll)
		 ...
		 ...
WHERE Bedingung
ORDER BY Spalte...


*/



-- "Expertenübung": 
-- EmployeeID, LastName, EmployeeId vom Chef, LastName vom Chef des jeweiligen Mitarbeiters

SELECT	  e1.EmployeeID
		, e1.LastName AS Employee
		, e1.ReportsTo
		, e2.LastName AS Boss
		, e2.FirstName
		, e2.HomePhone
		, e2.Title
FROM Employees e1 INNER JOIN Employees e2 ON e1.ReportsTo = e2.EmployeeID

-- mit INNER JOIN kommen nur 8 von 9 Mitarbeitern raus; derjenige, der keinen Vorgesetzten hat (der Firmenchef) steht bei INNER JOIN nicht auf der Mitarbeiterseite mit drin

SELECT	  e1.EmployeeID
		, e1.LastName AS Employee
		, e1.ReportsTo
		, e2.LastName AS Boss
		, e2.FirstName
		, e2.HomePhone
		, e2.Title
FROM Employees e1 LEFT JOIN Employees e2 ON e1.ReportsTo = e2.EmployeeID

-- mit LEFT JOIN bekommen wir hier 9 Ergebnisse, der Chef steht auch als Mitarbeiter drin, als Vorgesetzten hat er NULL, weil er als Firmenchef keinen Vorgesetzten hat. Möchte man trotzdem diese Ausgabe aber keine NULL-Werte eingetragen haben, kann man z.B. mit der ISNULL-Funktion arbeiten:

SELECT	  e1.EmployeeID
		, e1.LastName AS Employee
		, e1.ReportsTo
		, ISNULL(e2.LastName, 'Boss') AS Boss
		, ISNULL(e2.FirstName, 'Boss') AS [Boss Vorname]
		, ISNULL(e2.HomePhone, e1.HomePhone) AS Bosstel
		, ISNULL(e2.Title, 'Boss') AS Boss
FROM Employees e1 LEFT JOIN Employees e2 ON e1.ReportsTo = e2.EmployeeID