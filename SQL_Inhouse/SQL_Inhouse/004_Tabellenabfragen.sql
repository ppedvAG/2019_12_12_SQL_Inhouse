-- EINFACHE TABELLENABFRAGEN
-- SELECT auf Tabellen
-- Immer überprüfen, welche Datenbank verwendet wird!

USE Northwind;
GO


-- Syntax:
-- SELECT Spalte1, Spalte2, Spalte3, 'Text', Funktion(), Zahl
-- FROM Tabelle


-- Wildcard * (alles auswählen)
-- * sollte NICHT verwendet werden. Auch, wenn die gesamte Tabelle ausgegeben werden soll, sollten stattdessen die Spaltennamen angegeben werden.

SELECT *
FROM Customers

SELECT CompanyName
FROM Customers

SELECT	  CompanyName
		, ContactName
		, Phone
FROM Customers


SELECT	  CompanyName AS Firmenname
		, ContactName AS Kontaktperson
		, Phone AS Telefonnummer
FROM Customers


-- wenn Abstand im Namen wie bei Order Details, dann in eckiger Klammer schreiben!:
SELECT *
FROM [Order Details]

SELECT CONCAT('James', ' ', 'Bond') AS [vollständiger Name]

-- von Bestellungen Bestellnummer, welcher Kunde (CustomerID), welcher Angestellte (EmployeeID) hat verkauft, in welches Land ist geliefert worden?
-- Database Diagram erstellen/nachschlagen hilfreich!
-- Databases -> Northwind -> Database Diagrams -> Rechtsklick -> New Database Diagram

SELECT	  OrderID
		, CustomerID
		, EmployeeID
		, ShipCountry
FROM Orders


-- ******************************************** ÜBUNG
-- String Funktionen (Serverfunktionen) 4
-- Von der Telefonnummer aus der Customers-Tabelle sollen nur die letzten 3 Zeichen angezeigt werden; alle anderen sollen mit x ersetzt werden. (xxxxxxxxxxxxxxx789)

-- Lösungsmöglichkeit:
SELECT REPLICATE('x', (LEN(Phone)-3))
		+ SUBSTRING(Phone,(LEN(Phone)-2),3) AS TelNr
		, Phone
FROM Customers



-- ******************************************** ÜBUNGEN (Inhouse optional)
-- Tabellenabfragen Übungen 1 - 4
-- 1) Gib KundenID, Firmenname, Kontaktperson und Telefonnummer aller Kunden aus.
-- 2) Gib die ProduktID, den Produktnamen und den Stückpreis aus.
-- 3) Gib die Datumsdifferenz zwischen Lieferdatum und Wunschtermin der Bestellungen aus.
-- 4) Gib die Bestellnummer, den Wunschtermin, das Lieferdatum und die Lieferverzögerung aus.

-- 1

SELECT	  CustomerID AS KundenID
		, CompanyName AS Firmenname
		, ContactName AS Kontaktperson
		, Phone AS Telefonnummer
	FROM Customers

-- 2

SELECT	  ProductID AS ProduktID
		, ProductName AS Produktname
		, UnitPrice AS Stückpreis
FROM Products

-- 3

SELECT DATEDIFF(dd, RequiredDate, ShippedDate)
FROM Orders

-- 4

SELECT	  OrderID
		, RequiredDate
		, ShippedDate
		, DATEDIFF(dd, RequiredDate, ShippedDate) AS Lieferverzögerung
FROM Orders
ORDER BY Lieferverzögerung ASC -- ascending, in aufsteigender Reihenfolge = Defaultwert


SELECT	  OrderID
		, RequiredDate
		, ShippedDate
		, DATEDIFF(dd, RequiredDate, ShippedDate) AS Lieferverzögerung
FROM Orders
ORDER BY Lieferverzögerung DESC -- descending, in absteigender Reihenfolge (vom größten zum kleinsten Wert)




-- Brutto-/Nettofrachtkosten? MwSt?
SELECT	  Freight AS Nettofrachtkosten
		, Freight*1.19 AS Bruttofrachtkosten
		, Freight*0.19 AS MwSt
FROM Orders