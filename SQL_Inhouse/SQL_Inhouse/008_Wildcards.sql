-- WILDCARDS nur beim LIKE
-- au�er * beim SELECT (alle Spalten)

-- % steht f�r beliebig viele unbekannte Zeichen (0 - ?)

-- alle Kunden, deren KundenID mit 'ALF' beginnt
SELECT *
FROM Customers
WHERE CustomerID LIKE 'ALF%'

-- alle Kunden, deren KundenID mit 'MI' endet
SELECT *
FROM Customers
WHERE CustomerID LIKE '%MI'

-- alle Kunden, die IRGENDWO im Namen 'kist' haben
SELECT *
FROM Customers
WHERE CompanyName LIKE '%kist%'


-- alle, deren Firmenname mit D beginnt
SELECT *
FROM Customers
WHERE CompanyName LIKE 'D%'

-- alle, die mit D enden
SELECT *
FROM Customers
WHERE CompanyName LIKE '%D'

-- alle, die ein D enthalten
SELECT *
FROM Customers
WHERE CompanyName LIKE '%D%'




-- ******************************************** �BUNGEN
-- WHERE �bungen 7 - 10
-- 7) Gib alle Produkte aus, deren Name mit Coffee endet.
SELECT *
FROM Products
WHERE ProductName LIKE '%coffee'

-- 8) Gib alle Produkte aus, deren Name mit 'L' beginnt.
SELECT *
FROM Products
WHERE ProductName LIKE 'L%'


-- 9) Gib alle Produkte aus, die ein 'ost' im Namen haben.
SELECT *
FROM Products
WHERE ProductName LIKE '%ost%'



-- 10) Gib alle Produkte aus, die vom Anbieter (SupplierID) 5, 10 oder 15 stammen, von denen mehr als 10 St�ck vorr�tig sind und deren St�ckpreis unter 100 liegt. Ordne das Ergebnis absteigend vom h�chsten zum niedrigsten St�ckpreis.
SELECT *
FROM Products
WHERE SupplierID IN(5, 10, 15)
	AND UnitsInStock > 10
	AND UnitPrice < 100
ORDER BY UnitPrice DESC


-- alle, die ein d im Namen haben und mit e enden
SELECT *
FROM Customers
WHERE CompanyName LIKE('%d%e')

-- alle, die mit a beginnen, irgendwo ein f haben und aus Deutschland sind
SELECT *
FROM Customers
WHERE CompanyName LIKE('a%f%')
	AND Country = 'Germany'

-- Bestellungen: alle von Angestellten 1, 3, 5, von Kunden, die mit r beginnen und deren Frachtkosten gr��er als 100 sind
SELECT *
FROM Orders
WHERE EmployeeID IN(1,3,5)
	AND CustomerID LIKE 'r%'
	AND Freight > 100

-- z�hlen! COUNT()
-- wieviele Kunden gibts?

SELECT COUNT(CustomerID) AS Kundenanzahl
FROM Customers



-- ******************************************** �BUNG
-- WHERE �bung 11
-- 11) Wieviele Produkte bietet Anbieter Nr. 17 an?
SELECT COUNT(ProductID)
FROM [Products]
WHERE SupplierID = 17

-- SELECT * FROM Products ORDER BY SupplierID


-- Wo verwenden wir eckige Klammern?
-- Eckige Klammern z.B. bei [richtiger Name] wo Abstand dazwischen ist
-- Bsp.:
--SELECT *
--FROM [Order Details]


-- oder auch bei Wertebereichen:
-- Wertebereiche []
-- steht f�r genau 1 Zeichen aus einem bestimmten Bereich
-- funktioniert auch mit Sonderzeichen
-- funktioniert f�r 'von-bis' [a-c]


SELECT *
FROM Customers
WHERE CompanyName LIKE '%[%]%' -- irgendwo da drin muss ein %-Zeichen vorkommen


-- alle, die mit a, b oder c beginnen
SELECT *
FROM Customers
WHERE CompanyName LIKE '[a-c]%'

-- alle, die mit a oder c beginnen
-- entweder so:
SELECT *
FROM Customers
WHERE CompanyName LIKE 'a%'
	OR CompanyName LIKE 'c%'
-- oder so:
SELECT *
FROM Customers
WHERE CompanyName LIKE '[acd]%'


-- alle, die mit a-c oder e-g enden
-- entweder so:
SELECT *
FROM Customers
WHERE CompanyName LIKE '%[a-c]'
	OR CompanyName LIKE '%[e-g]'
--oder so:
SELECT *
FROM Customers
WHERE CompanyName LIKE '%[a-c|e-g]'


-- alle mit Hochkomma im Namen
SELECT *
FROM Customers
WHERE CompanyName LIKE '%''%' -- ACHTUNG: '', nicht ' 


-- Andere Schreibweise f�r Suche nach Sonderzeichen: ESCAPE

SELECT *
FROM Customers
WHERE CompanyName LIKE '%!%%' ESCAPE '!'  -- sucht nach % irgendwo im Namen


-- alle CompanyNames, die mit a oder c beginnen und mit einem m oder e enden
SELECT *
FROM Customers
WHERE CompanyName LIKE '[ac]%[me]'



-- ******************************************** �BUNG
-- WHERE �bung 12
-- 12) Gib alle Produkte aus, deren Name mit D-L beginnt und mit a, b, c, d oder m, n, o endet.

SELECT *
FROM Products
WHERE ProductName LIKE '[d-l]%' AND (ProductName LIKE '%[a-d]' OR ProductName LIKE '%[m-o]')


-- Oder:

SELECT *
FROM Products
WHERE ProductName LIKE '[d-l]%[a-d|m-o]' -- | steht f�r oder innerhalb der eckigen Klammern



-- unsere CustomerID besteht aus 5 Buchstaben
-- angenommen, es ist Fehler passiert
-- CMXY5... wie finde ich die falschen Eintr�ge?


-- wie w�rde ich die richtigen Eintr�ge finden?
-- entweder so:
SELECT *
FROM Customers
WHERE CustomerID LIKE '[a-z][a-z][a-z][a-z][a-z]'
--oder so:
SELECT *
FROM Customers
WHERE CustomerID LIKE REPLICATE('[a-z]', 5)

-- wie finde ich die falschen Eintr�ge?
SELECT *
FROM Customers
WHERE CustomerID NOT LIKE '[a-z][a-z][a-z][a-z][a-z]'

/*
SELECT *
FROM Tabelle
WHERE Pin NOT LIKE '[0-9][0-9][0-9][0-9]'
*/


-- NOT - nicht!
SELECT *
FROM Customers
WHERE CompanyName LIKE '[^a-c]%' -- ^steht f�r NICHT, also alle, die NICHT mit a, b oder c beginnen


-- wie bekommt man eine Ausgabe mit einem unbekannten Zeichen:
-- vorletztes Zeichen unbekannt:
SELECT *
FROM Customers
WHERE Phone LIKE '(5) 555-47[0-9]9'
-- oder:
SELECT *
FROM Customers
WHERE Phone LIKE '(5) 555-47_9' -- _ (Unterstrich) steht f�r genau 1 unbekanntes Zeichen


/*
	WILDCARDS ZUSAMMENFASSUNG:

	* beim SELECT = alle
	% beim LIKE - beliebig viele (0, 1, 2, ...)
	_ beim LIKE - genau 1 unbekanntes Zeichen
	[...] beim LIKE - 1 unbekanntes Zeichen aus einem bestimmten Wertebereich

*/


-- alle Kunden, die mit d-f beginnen, der letzte Buchstabe ist ein l und der drittletzte ein d

SELECT *
FROM Customers
WHERE CompanyName LIKE '[d-f]%d_l'


/*
	m�gliche Ergebnisse z.B.

	ddxl
	edel
	fxxxxxxxxxdxl

	Ernst Handel (in Northwind DB Customers)
	E........d.l

*/




