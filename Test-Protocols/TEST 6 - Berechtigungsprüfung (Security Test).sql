/* TEST 6: Berechtigungsprüfung (Security Test)
   Ziel: Nachweis, dass der 'CafeAppUser' Daten lesen, aber keine 
   Strukturen löschen darf (DDR-Einschränkung).
*/

-- Ausführen als der neu angelegte User
EXECUTE AS USER = 'CafeAppUser';

-- Dieser Befehl sollte funktionieren:
SELECT TOP 5 * FROM Product;

-- Dieser Befehl muss fehlschlagen (DROP Table):
BEGIN TRY
    DROP TABLE OrderItem;
END TRY
BEGIN CATCH
    PRINT 'Sicherheitstest bestanden: User darf keine Tabellen löschen.';
END CATCH;

REVERT; -- Zurück zum Admin-Status
GO