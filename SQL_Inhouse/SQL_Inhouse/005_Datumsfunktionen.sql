-- DATUMSFUNKTIONEN

USE Northwind;

-- **************************** DATUM ABFRAGEN ************************************************************

-- auf 3-4 Millisekunden genau; Datentyp datetime, 8 byte
SELECT GETDATE() 
-- auf Nanosekunden genau; Datentyp datetime2, 6-8 byte
SELECT SYSDATETIME() 


-- ******************************** DATUMSBERECHNUNGEN: DATEADD ********************************************
SELECT DATEADD(hh, 10, '2019-11-04') -- wenn nicht genauer angegeben, wird von 0:00 Uhr ausgegangen
									 -- '04.11.2019' , '4.11.2019' Vorsicht mit Format!

SELECT DATEADD(hh, 10, '4.11.2019')  -- Vorsicht mit Datumsformat!! --> Was ist Tag, was ist Monat?
-- SELECT CONVERT(varchar, DATEADD(hh, 10, '4.11.2019'), 113) -- wird offenbar als 11.April interpretiert!!

-- Stunden, Minuten, Sekunden, ... können optional angegeben werden
SELECT DATEADD(hh, 10, '2019-11-04 09:57')

-- aktuelles Datum inklusive Uhrzeit (inklusive Millisekunden) mit DATEADD kombinieren
SELECT DATEADD(hh, 10, GETDATE()) 

SELECT DATEADD(dd, 38, GETDATE())


-- negative Vorzeichen sind erlaubt, wir können so auch ein bestimmtes Intervall von einem Datum abziehen
SELECT DATEADD(dd, -38, GETDATE())


-- ******************************** DATUMSBERECHNUNGEN: DATEDIFF *******************************************
-- Differenz zwischen zwei Daten
SELECT DATEDIFF(dd, '2019-11-04', '2019-12-24')
SELECT DATEDIFF(dd, '2019-12-24', '2019-11-04') -- mit negativem Vorzeichen, gleicher Wert

-- auch hier können wir eine Differen zum aktuellen Datum abfragen
SELECT DATEDIFF(dd, GETDATE(), '2019-12-24')



-- ********************************* DATUMSTEILE AUSGEBEN: DATEPART ****************************************
SELECT DATEPART(dd, '2019-11-04')
SELECT DATEPART(mm, '2019-11-04')

-- In welchem Quartal liegt...?
SELECT DATEPART(qq, '2019-12-24')


/*
Intervalle:


    year, yyyy, yy = Year
    quarter, qq, q = Quarter
    month, MM, M = month
    week, ww, wk = Week
    day, dd, d = Day
    hour, hh = hour
    minute, mi, n = Minute
    second, ss, s = Second
    millisecond, ms = Millisecond
	nanosecond, ns
    weekday, dw, w = Weekday
    dayofyear, dy, y = Day of the year


*/



-- ***************************** DATENAME *********************************************************************+
-- bei Datename machen eigentlich nur zwei Sinn: dw (Wochentag) und month (Monatsname)
SELECT DATENAME(dd, '2019-11-04') -- dd bringt hier nichts, wir bekommen damit eine Zahl zurück

SELECT DATENAME(dw, '2019-11-04') -- dw für day of the week (Wochentag)

SELECT DATENAME(month, '2019-11-04')








-- ******************************************** ÜBUNGEN
--1) Welches Datum haben wir in 38 Tagen?

SELECT DATEADD(dd, 38, GETDATE())

--2) Welcher Wochentag war Dein Geburtstag?
SELECT DATENAME(dw, '1981-04-22')

--3) Vor wievielen Jahren kam der erste Star Wars Film in die Kinos? (25. Mai 1977 )
SELECT DATEDIFF(yy, getdate(), '1977') -- Ergebnis: -42 (mit negativem Vorzeichen)
SELECT DATEDIFF(yy, '1977', getdate()) -- Ergebnis: 42
-- ob ein negatives Vorzeichen bei DATEDIFF Sinn macht, ist abhängig von der Fragestellung

--4) In welchem Quartal liegt der österreichische Nationalfeiertag (26.10.)?
SELECT DATEPART(qq, '2019-10-26') AS Quartal

--5) Gib Tag, Monat und Jahr Deines Geburtstages in einer eigenen Spalte mit der jeweils entsprechenden Überschrift an:

-- Tag	 Monat	 Jahr
--  22	  04	 1981
SELECT	  DATEPART(dd, '1981-04-22') AS Tag
		, DATEPART(MM, '1981-04-22') AS Monat
		, DATEPART(yyyy, '1981-04-22') AS Jahr

-- ODER:
SELECT	  DAY('1981-04-22') AS Tag
		, MONTH('1981-04-22') AS Monat
		, YEAR('1981-04-22') AS Jahr


-- ********************************* DAY, MONTH, YEAR ********************************************
-- gleiches Ergebnis wie mit DATEPART dd, MM, yy
-- 4 byte Speicherplatz
-- Tag/Monat/Jahr als INTEGERWERT
SELECT DAY('2019-11-04')
SELECT MONTH('2019-11-04')
SELECT YEAR('2019-11-04')



-- Beispiel mit DB:
USE Northwind

SELECT YEAR(HireDate) AS Einstellungsjahr
FROM Employees

SELECT HireDate
FROM Employees








