/* TEST 5: Validierung der Constraints
   Ziel: Sicherstellen, dass keine ungültigen Daten (z. B. negative Preise)
   in die Tabelle 'Product' eingegeben werden können.
*/

BEGIN TRY
    INSERT INTO Product (ProductName, Price, CategoryID)
    VALUES ('Fehlerhaftes Produkt', -10.50, 1);
END TRY
BEGIN CATCH
    PRINT 'Constraint-Check erfolgreich: Negativer Preis wurde abgelehnt.';
    PRINT 'Fehlermeldung: ' + ERROR_MESSAGE();
END CATCH;
GO