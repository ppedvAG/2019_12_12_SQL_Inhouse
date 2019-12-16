-- tempor�re Tabellen
-- temporary tables

/*

-- lokale tempor�re Tabellen
-- existieren nur in der aktuellen Session

-- globale tempor�re Tabellen
-- Zugriff auch von anderen Sessions


-- h�lt nur so lange, wie Verbindung da ist
-- kann auch gel�scht werden

*/

SELECT CustomerID, Freight
INTO #t1
FROM Orders

SELECT *
FROM #t1


-- k�nnen theoretisch auch wie eine normale Tabelle gel�scht werden

DROP TABLE #t1


-- Syntax: DROP TABLE Tablename