-- FORMAT, CONVERT und CAST - in welchem Format wollen wir etwas darstellen?

USE Northwind;

-- ************************************ CAST: UMWANDELN VON DATENTYPEN *************************************

-- funktioniert:
SELECT '123' + 2

-- funktioniert NICHT:
SELECT '123.3' + 2
-- Conversion failed when converting the varchar value '123.3' to data type int.

-- funktioniert NICHT:
DECLARE @demo01 AS varchar(10) = '123.3'
SELECT @demo01 + 2
-- Conversion failed when converting the varchar value '123.3' to data type int.


/*
	implizite und explizite Konvertierung in der Microsoft-Dokumentation:
	https://docs.microsoft.com/de-de/sql/t-sql/data-types/data-type-conversion-database-engine?view=sql-server-ver15
*/

-- muss in entsprechenden Datentyp umgewandelt werden:
-- funktioniert:
SELECT CAST('123.3' AS float) + 2


-- geht auch mit Datum, ABER: kein Einfluss auf das Format!
SELECT CAST(SYSDATETIME() AS varchar)

-- VORSICHT auch mit Anzahl der Zeichen
SELECT CAST(SYSDATETIME() AS varchar(3)) -- macht keinen Sinn!

-- mit Abfrage aus DB (nur mit CAST kein Einfluss auf das Format):
SELECT CAST(BirthDate AS varchar) FROM Employees
-- zum Vergleich:
SELECT BirthDate FROM Employees

-- VORSICHT: umgekehrt kann das leicht zu Problemen führen!
SELECT CAST('2019-11-01' AS date) -- systemabhängig kann hier auch 11.01.2019 als Ergebnis herauskommen!


-- ********************************************* CONVERT **************************************************
-- auch mit CONVERT werden, wie der Funktionsname schon sagt, Datentypen konvertiert; allerdings haben wir hier auch die Möglichkeit, einen Style-Parameter einzugeben

-- Syntax: CONVERT(data_type[(length)], expression[, style])
-- CONVERT(1 in welchen Datentyp soll konvertiert werden, 2 was soll konvertiert werden, 3 optional: wie soll die Ausgabe aussehen)

SELECT CONVERT(varchar(10), 12345.5)

-- funktioniert auch mit Datum
SELECT CONVERT(varchar, SYSDATETIME())

-- wieder aufpassen mit Länge:
SELECT CONVERT(varchar(3), SYSDATETIME()) -- sinnlos!!


-- über den Style-Parameter geben wir das Format an, in dem die Datumsausgabe erfolgen soll

SELECT CONVERT(varchar, SYSDATETIME(), 4) -- nur letzte zwei Stellen der Jahreszahl
SELECT CONVERT(varchar, SYSDATETIME(), 104) -- Jahreszahl vierstellig


-- unterschiedliche Regionen:

SELECT	  CONVERT(varchar, SYSDATETIME(), 104) AS DE
		, CONVERT(varchar, SYSDATETIME(), 101) AS US
		, CONVERT(varchar, SYSDATETIME(), 103) AS GB

-- Date und Time Styles in der Microsoft Dokumentation:
/*
	https://docs.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-2017#date-and-time-styles
*/




-- ********************************************* FORMAT ****************************************************
-- Ausgabe-Datentyp ist nvarchar

SELECT FORMAT(1234567890, '###-###/##-##') -- 123-456/78-90

SELECT FORMAT(431234567890, '+' + '##/### ## ## ###') -- +43/123 45 67 890

-- Syntax: SELECT FORMAT(Datum, Format)
SELECT FORMAT(GETDATE(), 'dd.MM.yyyy') -- AUSNAHMEFALL!!!! MM = Monat, mm = Minute!! MM großschreiben!

SELECT FORMAT(GETDATE(), 'd.MM.yyyy') AS Datum

-- FEHLERMELDUNG:
SELECT FORMAT('2019-10-05', 'dd.MM.yyyy')
-- Argument data type varchar is invalid for argument 1 of format function.

-- Datum aus Datenbank:
SELECT FORMAT(HireDate, 'dd.MM.yyyy') AS HireDate FROM Employees

-- mit Culture-Parameter:
SELECT	  FORMAT(SYSDATETIME(), 'd', 'de-de') AS DE
		, FORMAT(SYSDATETIME(), 'd', 'en-US') AS US
		, FORMAT(SYSDATETIME(), 'd', 'en-GB') AS GB

-- kleines "d" bedeutet, Datum in Zahlen ausgegeben, großes "D" bedeutet, Monat (und je nach regionaler Konvention auch der Wochentag) wird als Text ausgeschrieben
SELECT FORMAT(SYSDATETIME(), 'D', 'en-GB')

-- Supported Culture Codes in der Microsoft-Dokumentation:
/*
	https://docs.microsoft.com/de-de/bingmaps/rest-services/common-parameters-and-types/supported-culture-codes
*/




SELECT CAST(123.456789 AS DECIMAL(5, 2)) -- rundet!

-- SELECT CONVERT(DECIMAL(5, 2), 123.456789)

SELECT REPLACE('123.23', '.', ',')