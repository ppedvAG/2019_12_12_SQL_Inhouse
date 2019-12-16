-- SIMPLE SELECT, einfache Abfragen

USE Northwind;

/*

Text, Zahlen, Rechnungen möglich

*/


-- ZAHL AUSGEBEN
SELECT 100;
GO

-- TEXT AUSGEBEN
SELECT 'Testtext'

-- RECHNUNG
SELECT 100*3 -- 300


SELECT '100*3' -- 100*3... unter Anführungszeichen = Text!

SELECT 100, 'Testtext' -- zwei Spalten


-- SPALTENÜBERSCHRIFT
-- SELECT Auswahl AS (als) Spaltenüberschrift
SELECT 'Leo' AS Kunde




-- FORMAT?
SELECT 100, 
		'Testtext', 
		'mehr Text', -- in der letzten Zeile darf kein Komma stehen; Problem, wenn auskommentiert wird:
		--'Info'

-- Fehlermeldung, wegen Kommas oben:

-- bisschen schöner so, dann kann alles auskommentiert werden und funktioniert trotzdem:
SELECT    100
		, 'Testtext'
		, 'mehr Text'
		--, 'Info'


-- Groß-/Kleinschreibung
select 100

select 100


-- STRG + SHIFT + U (uppercase), STRG + SHIFT + L (lowercase)

select *
from Customers


-- ******************************************** ÜBUNG
-- Simple Select Übung 1

--1)  Ausgabe mit Tabellenüberschriften:
-- Zahl	             Text	                 Rechnung
--  100	  Donaudamfschifffahrtsgesellschaft	    200

--Die Ausgabe unter „Rechnung“ soll sich aus einer Berechnung im SELECT ergeben.
SELECT	  100 AS Zahl
		, 'Donaudampfschifffahrtsgesellschaft' AS Text
		, 400/2 AS Rechnung
