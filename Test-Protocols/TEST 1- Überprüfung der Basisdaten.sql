/* TEST 1: Überprüfung der Basisdaten
   Ziel: Sicherstellen, dass alle 14 Tabellen Daten enthalten.
*/
SELECT 'Kunden' AS Tabelle, COUNT(*) AS Anzahl FROM Customer
UNION SELECT 'Produkte', COUNT(*) FROM Product
UNION SELECT 'Mitarbeiter', COUNT(*) FROM Employee
UNION SELECT 'Lagerbestand', COUNT(*) FROM Inventory;
-- Erwartung: Alle Tabellen müssen Werte > 0 anzeigen.
GO