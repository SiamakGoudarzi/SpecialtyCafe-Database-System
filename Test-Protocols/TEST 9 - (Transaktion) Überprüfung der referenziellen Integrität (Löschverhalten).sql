/* TEST 9: Überprüfung der referenziellen Integrität (Löschverhalten)
   
   BESCHREIBUNG: 
   Dieser Test simuliert den Versuch, einen Auftrag aus der Tabelle [Order] zu löschen, 
   der noch verknüpfte Positionen in [OrderItem] besitzt.
   
   ZIEL: 
   Sicherstellen, dass das System keine Dateninkonsistenz zulässt (Restrict-Verhalten).
   Dies entspricht den Anforderungen an die Datensicherheit gemäß Punkt 13 und 31.
*/

BEGIN TRANSACTION;

BEGIN TRY
    -- Versuch, die älteste Bestellung zu löschen (Parent-Datensatz)
    DELETE FROM [Order] 
    WHERE OrderID = (SELECT MIN(OrderID) FROM [Order]);

    -- Dieser Teil wird nur ausgeführt, wenn keine FK-Verletzung vorliegt
    PRINT 'HINWEIS: Löschung durchgeführt (CASCADE oder keine Abhängigkeiten).';
END TRY
BEGIN CATCH
    -- Erwartetes Ergebnis: Fehlermeldung 547 (REFERENCE-Einschränkung)
    IF ERROR_NUMBER() = 547
    BEGIN
        PRINT 'ERGEBNIS: Referenzielle Integrität erfolgreich geprüft.';
        PRINT 'STATUS: Die Löschung wurde blockiert, da noch OrderItems existieren.';
        PRINT 'SYSTEM-MELDUNG: ' + ERROR_MESSAGE();
    END
    ELSE
    BEGIN
        PRINT 'UNERWARTETER FEHLER: ' + ERROR_MESSAGE();
    END
END CATCH;

-- WICHTIG: Die Transaktion wird zurückgesetzt, um die Testdaten für die Präsentation zu erhalten.
ROLLBACK TRANSACTION;
GO