-- DISTINCT


-- wie bekomme ich eine Liste aller Länder, in die geliefert wird?

SELECT Country
FROM Customers

-- Länder stehen mehrfach da, weil wir alle Kunden herausbekommen und es mehrere Kunden in einem Land gibt
-- 91 Zeilen Ergebnis, 1 Zeile pro Kunde, Germany z.B. kommt mehrfach vor

-- Lösung:
SELECT DISTINCT Country
FROM Customers
-- 21 Zeilen Ergebnis - jedes Land kommt nur mehr einmal vor



SELECT DISTINCT CustomerID, Country
FROM Customers
-- bringt nix, weil dann wieder alle Kunden aus der Kundentabelle ausgegeben werden



SELECT DISTINCT Country, City
FROM Customers
-- so viele Ergebnisse wie Städte; Länder kommen öfter vor, weil es mehrere verschiedene Städte in einem Land geben kann


-- Liste von allen Städten, in denen wir auch Kunden haben?
SELECT DISTINCT City
FROM Customers


-- Liste von allen Ländern, in denen Angestellte wohnen
SELECT DISTINCT Country
FROM Employees -- USA, UK

-- zur Kontrolle:
SELECT *
FROM Employees
-- ja tatsächlich, unsere Angestellten sind nur in den USA und den UK (Northwind DB)
