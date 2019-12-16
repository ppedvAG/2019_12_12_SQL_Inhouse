-- NULL
USE Northwind;

-- = NULL funktioniert nicht!
-- jede mathematische Operation und auch Vergleiche mit NULL im WHERE führen wieder zu NULL

-- NEIN: xx = NULL, xx != NULL, xx < NULL, xx > NULL (letztere zwei machen sowieso keinen Sinn!!)....
-- JA: xx IS NULL, xx IS NOT NULL


-- NEIN:
SELECT *
FROM Customers
WHERE Region < 'A'  -- faaaaaalsch!

-- NEIN:
SELECT *
FROM Customers
WHERE Region = NULL  -- faaaaalsch!

-- JA:
SELECT *
FROM Customers
WHERE Region IS NULL