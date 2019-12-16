
-- HÄUFIG VERWENDETE SERVERFUNKTIONEN

-- ************************************** TRIM, LEN, DATALENGTH ********************************************

SELECT 'Test'

-- ein Eintrag wurde eventuell mit Leerzeichen aufgefüllt oder enthält versehentlich Leerzeichen

SELECT 'Test                '

-- TRIM, LTRIM, RTRIM entfernt unerwünschte Leerzeichen vor und nach dem Text

SELECT RTRIM('Test                ') -- RTRIM = right trim, entfernt Leerzeichen rechts
SELECT LTRIM('                Test') -- LTRIM = left trim, entfernt Leerzeichen links

SELECT LEN('Test') -- Length (wieviele Zeichen sind das?)

SELECT LEN('Test                ') -- zählt Leerzeichen nicht mit!

SELECT DATALENGTH('Test                ') -- zählt Leerzeichen mit

SELECT DATALENGTH(RTRIM('Test                ')) -- viele Zeichen, nachdem ich Leerzeichen weggeschnitten habe?

-- ltrim: Leerzeichen links weg, rtrim: Leerzeichen rechts weg

-- links und rechts Leerzeichen weg: TRIM()


SELECT TRIM('     Text     ')
SELECT DATALENGTH('     Text     ')
SELECT DATALENGTH(TRIM('     Text     '))


-- DATALENGTH: vorsicht bei Datentyp nchar, nvarchar! Doppelt so viel! (Wegen Unicode.)

USE Northwind
SELECT DATALENGTH(CustomerID) FROM Customers WHERE CustomerID = 'ALFKI' -- 10! Weil Datentyp nchar(10)
SELECT LEN(CustomerID) FROM Customers WHERE CustomerID = 'ALFKI' -- 5
SELECT DATALENGTH(CompanyName) FROM Customers WHERE CustomerID = 'ALFKI' -- 38! Weil Datentyp nchar(10)
SELECT LEN(CompanyName), CompanyName FROM Customers WHERE CustomerID = 'ALFKI' -- 19
-- hat nichts mit Leerzeichen zu tun:
SELECT DATALENGTH(TRIM(CompanyName)) FROM Customers WHERE CustomerID = 'ALFKI' -- trotzdem noch 38
SELECT LEN(TRIM(CompanyName)), CompanyName FROM Customers WHERE CustomerID = 'ALFKI' -- 19; Leerzeichen in der Mitte bleibt erhalten



-- ******************************************* REVERSE *********************************************************
-- Text in umgekehrter Reihenfolge anzeigen
-- hmmm....
SELECT REVERSE('REITTIER')
SELECT REVERSE ('Trug Tim eine so helle Hose nie mit Gurt?')



-- ********************************** AUSSCHNEIDEN: LEFT, RIGHT, SUBSTRING **************************************************
-- Zeichen "ausschneiden":

-- schneidet die ersten vier Zeichen aus (Test)
SELECT LEFT('Testtext', 4)

--schneidet die letzten vier Zeichen aus (text)
SELECT RIGHT('Testtext', 4)

-- Textausschnitt erstellen mit Substring
SELECT SUBSTRING('Testtext', 4, 2) -- ab welcher Stelle (4) möchte man wieviele Zeichen (2) ausschneiden
-- Ergebnis: tt


-- ******************************************** STUFF **********************************************************
-- Text einfügen ("reinstopfen") mit STUFF
SELECT STUFF('Testtext', 5, 0, '_Hallo_')
-- wo soll etwas eingefügt werden? beginnend bei welcher Stelle? (5)
-- wieviel soll weggelöscht werden (0)
-- was soll eingefügt werden ('_Hallo_')


-- ******************************************** ÜBUNG
-- String Funktionen (Serverfunktionen) Übung 1
-- Die letzten drei Stellen der Telefonnummer sollen durch xxx ersetzt werden: +49 86779889xxx

-- Möglichkeit 1
SELECT LEFT('1234567890', 7)+ 'xxx' -- geht nur für Telefonnummern mit gleicher Länge!

-- Möglichkeit 2
SELECT LEFT('1234567890', DATALENGTH('1234567890')-3)+ 'xxx'

-- Möglichkeit 3
SELECT STUFF('+49 86779889123', 13, 3, 'xxx') -- geht nur für Telefonnummern mit gleicher Länge!

-- Möglichkeit 4
SELECT REVERSE(STUFF(REVERSE('+49 86779889123'), 1, 3, 'xxx'))



-- ******************************************** ÜBUNG
-- String Funktionen (Serverfunktionen) Übung 2
-- Angenommen, durch einen Fehler gibt es Leerzeichen in einem String:        '___Test___'
--	.a) Entferne die Leerzeichen
--  .b) Gib die Länge des Strings vorher und nachher in einer Tabelle aus:
--			Vorher	Nachher
--			  14	   4

-- Lösung:
-- .a)
SELECT TRIM('     Test     ')
-- .b)
SELECT	  DATALENGTH('     Test     ') AS Vorher
		, DATALENGTH(TRIM('     Test     ')) AS Nachher


-- ******************************* CONCAT - Strings zusammenfügen **********************************************
-- Strings zusammenfügen mit CONCAT()

SELECT CONCAT('abc', 'def', 'ghi', 'jkl', 'mno', 'pqr', 'stu', 'vwx', 'yz')

SELECT CONCAT('Ich weiß, ', 'dass ich', ' nichts weiß.') AS Zitat

SELECT CONCAT('James', ' ', 'Bond') AS FullName


--SELECT CONCAT(FirstName, ' ', LastName) AS FullName
--FROM Tabelle


SELECT CONCAT(TRIM('James'), ' ', TRIM('Bond')) AS FullName


-- SELECT CONCAT(TRIM(FirstName), ' ', TRIM(LastName)) AS FullName
-- FROM Tabellenname




-- ******************************************** ÜBUNG
-- String Funktionen (Serverfunktionen) Übung 3
-- Korrigiere die Fehler im Namen: Wilham Shakesbeer --> William Shakespeare
-- Dabei sollen Buchstaben, die schon stimmen, beibehalten werden.

-- mögliche Lösung:
SELECT	  CONCAT(
		      SUBSTRING((STUFF('Wilham Shakesbeer', 4, 1, 'li')), 1, 14)
		    , SUBSTRING((STUFF('Wilham Shakesbeer', 14, 4, 'pe')), 14, 5)
			, SUBSTRING((STUFF('Wilham Shakesbeer',17, 0, 'a')), 17, 2)
			, 'e'
		  )






-- ************************************ REPLICATE - ZEICHEN MEHRFACH AUSGEBEN  *****************************************
-- ein Zeichen oder eine Zeichenfolge mehrfach ausgeben mit REPLICATE

SELECT REPLICATE ('?', 5) -- ?????
SELECT REPLICATE('abc', 3) -- abcabcabc


-- Übung 4
--4) Von der Telefonnummer aus der Customers-Tabelle sollen nur die letzten 3 Zeichen angezeigt werden; alle anderen sollen mit x ersetzt werden. (xxxxxxxxxxxxxxx789)
--.a) optional: Gleiche Übung wie oben, aber mit AdventureWorks Datenbank: Nur die letzten drei Stellen der Kreditkartennummer aus der CreditCard-Tabelle sollen angezeigt werden. 

SELECT REPLICATE('x', (LEN(Phone)-3))
		+ SUBSTRING(Phone,(LEN(Phone)-2),3) AS TelNr
		, Phone
FROM Customers


SELECT REPLICATE('x', (LEN(Phone)-3))
		+ REVERSE(LEFT(REVERSE(Phone), 3)) AS TelNr
		, Phone
FROM Customers





-- *********************************** GROß- UND KLEINBUCHSTABEN *******************************************************
-- alles in Großbuchstaben ausgeben:
SELECT UPPER(LastName)
FROM Employees

-- alles in Kleinbuchstaben ausgeben:
SELECT LOWER(LastName)
FROM Employees


-- ************************************************* CHARINDEX **********************************************************
-- an welcher Stelle befindet sich ein gesuchtes Zeichen?
-- Buchstabe
SELECT CHARINDEX('a', 'Leo') -- 0
-- Groß-/Kleinschreibung in der Suche spielt keine Rolle
SELECT CHARINDEX('f', 'ALFKI') -- 3
SELECT CHARINDEX('F', 'ALFKI') -- 3
-- Leerzeichen gesucht
SELECT CHARINDEX(' ', 'James Bond') -- 6
--Zeichenfolge gesucht
SELECT CHARINDEX('schnecke', 'Zuckerschnecke') -- 7; an welcher Stelle beginnt die gesuchte Zeichenfolge

-- Charindex gibt die ERSTE Stelle an, an der das gesuchte Zeichen gefunden wird
SELECT CHARINDEX(' ', 'Klaus Maria Brandauer') -- 6

-- wie finde ich das letzte Leerzeichen?
SELECT LEN('Georg Friedrich Händel')-CHARINDEX(' ', REVERSE('Georg Friedrich Händel'))+1 -- 16
SELECT LEN('Wolfgang Amadeus Mozart')-CHARINDEX(' ', REVERSE('Wolfgang Amadeus Mozart'))+1 -- 17


-- mit Funktion
-- drop function dbo.fnLastIndexOf

--create function fnLastIndexOf(@char char(1), @text varChar(50))
--returns int
--as
--begin
--return len(@text) - charindex(@char, reverse(@text)) +1
--end

--select dbo.fnLastIndexOf(' ', 'Wolfgang Amadeus Mozart') AS [letztes Leerzeichen]



-- auch nach Sonderzeichen suchen funktioniert
SELECT CHARINDEX('$', '450$') -- 4
SELECT CHARINDEX('%', '20%') -- 3


-- ********************************** ZEICHEN ERSETZEN: REPLACE *******************************************************
SELECT REPLACE('Hallo!', 'a', 'e') -- Hello!

-- mehr als ein Zeichen ersetzen ist möglich (muss verschachtelt werden):
SELECT REPLACE(REPLACE('Hallo!', 'a', 'e'), '!', '?') -- Hello?
SELECT REPLACE(REPLACE(REPLACE('Hallo!', 'H', 'B'), 'a', 'e'), '!', '?') -- Bello?

