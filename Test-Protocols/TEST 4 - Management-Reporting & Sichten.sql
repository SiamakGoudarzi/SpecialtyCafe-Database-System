/* TEST 4: Management-Reporting & Sichten
   Ziel: Test der Views mit JOINs, GROUP BY und HAVING.
*/

-- 1. Performance-Analyse der Mitarbeiter (Umsatz-Ranking)
SELECT * FROM vw_EmployeePerformance;

-- 2. Lager-Warnsystem (Kritische Bestände)
-- Diese Funktion identifiziert Produkte unter dem Mindestbestand.
SELECT * FROM dbo.fn_InventoryAlert();

-- 3. CRM-Analyse: Inaktive Kunden finden
-- Testet den LEFT JOIN zwischen Customer und Order.
SELECT * FROM vw_InactiveClients;
GO