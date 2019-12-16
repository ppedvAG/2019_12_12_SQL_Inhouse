-- SIMPLE SELECT, einfache Abfragen

USE Northwind;

/*

Text, Zahlen, Rechnungen m�glich

*/


-- ZAHL AUSGEBEN
SELECT 100;
GO

-- TEXT AUSGEBEN
SELECT 'Testtext'

-- RECHNUNG
SELECT 100*3 -- 300


SELECT '100*3' -- 100*3... unter Anf�hrungszeichen = Text!

SELECT 100, 'Testtext' -- zwei Spalten


-- SPALTEN�BERSCHRIFT
-- SELECT Auswahl AS (als) Spalten�berschrift
SELECT 'Leo' AS Kunde




-- FORMAT?
SELECT 100, 
		'Testtext', 
		'mehr Text', -- in der letzten Zeile darf kein Komma stehen; Problem, wenn auskommentiert wird:
		--'Info'

-- Fehlermeldung, wegen Kommas oben:

-- bisschen sch�ner so, dann kann alles auskommentiert werden und funktioniert trotzdem:
SELECT    100
		, 'Testtext'
		, 'mehr Text'
		--, 'Info'


-- Gro�-/Kleinschreibung
select 100

select 100


-- STRG + SHIFT + U (uppercase), STRG + SHIFT + L (lowercase)

select *
from Customers


-- ******************************************** �BUNG
-- Simple Select �bung 1

--1)  Ausgabe mit Tabellen�berschriften:
-- Zahl	             Text	                 Rechnung
--  100	  Donaudamfschifffahrtsgesellschaft	    200

--Die Ausgabe unter �Rechnung� soll sich aus einer Berechnung im SELECT ergeben.
SELECT	  100 AS Zahl
		, 'Donaudampfschifffahrtsgesellschaft' AS Text
		, 400/2 AS Rechnung
