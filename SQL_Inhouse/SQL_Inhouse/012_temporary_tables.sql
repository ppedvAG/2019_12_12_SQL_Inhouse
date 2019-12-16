-- temporäre Tabellen
-- temporary tables

/*

-- lokale temporäre Tabellen
-- existieren nur in der aktuellen Session

-- globale temporäre Tabellen
-- Zugriff auch von anderen Sessions


-- hält nur so lange, wie Verbindung da ist
-- kann auch gelöscht werden

*/

SELECT CustomerID, Freight
INTO #t1
FROM Orders

SELECT *
FROM #t1


-- können theoretisch auch wie eine normale Tabelle gelöscht werden

DROP TABLE #t1


-- Syntax: DROP TABLE Tablename