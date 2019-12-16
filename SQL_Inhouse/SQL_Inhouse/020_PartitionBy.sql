USE Northwind;

-- bisher:
SELECT	  ShipVia
		, AVG(Freight) AS avg_freight
FROM Orders
GROUP BY ShipVia
ORDER BY ShipVia
-- wir bekommen die durchschnittlichen Frachtkosten PRO Fr�chter (ShipVia)

--	SELECT * from orders



-- wenn wir aber mehrere Spalten ausgeben wollen, funktioniert das AVG nicht mehr wie geplant:
SELECT	  OrderID
		, CustomerID
		, ShipVia
		, AVG(Freight) AS avg_freight
FROM Orders
GROUP BY ShipVia, OrderID, CustomerID
ORDER BY ShipVia
-- bringt nix, weil wieder alle Orders ausgegeben werden; jetzt stehen keine AVG freight dabei, sondern die jeweiligen Frachtkosten


-- L�sung: m�glich mit OVER( PARTITION BY Spaltenname) AS Spalten�berschrift)
SELECT OrderID
		, CustomerID
		, ShipVia
		, AVG(Freight) OVER (
			PARTITION BY ShipVia
		  ) AS avg_freight
FROM Orders