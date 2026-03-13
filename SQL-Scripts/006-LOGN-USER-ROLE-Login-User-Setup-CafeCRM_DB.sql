/* ============================================================
   Login & User Setup für CafeCRM_DB
   Beschreibung:
   Erstellt einen eingeschränkten Benutzer für die Anwendung.
   Der Benutzer darf nur Daten lesen und schreiben.
   ============================================================ */

USE master;
GO

-- Login erstellen (falls nicht vorhanden)
IF NOT EXISTS (
    SELECT * FROM sys.server_principals 
    WHERE name = 'CafeAppUser'
)
BEGIN
    CREATE LOGIN CafeAppUser 
    WITH PASSWORD = 'CafePass123!', CHECK_POLICY = OFF;
END;
GO

USE CafeCRM_DB;
GO

-- User neu erstellen (Synchronisation sicherstellen)
IF EXISTS (
    SELECT * FROM sys.database_principals 
    WHERE name = 'CafeAppUser'
)
BEGIN
    DROP USER CafeAppUser;
END;
GO

CREATE USER CafeAppUser FOR LOGIN CafeAppUser;
GO

-- Berechtigungen vergeben (Least Privilege)
ALTER ROLE db_datareader ADD MEMBER CafeAppUser;
ALTER ROLE db_datawriter ADD MEMBER CafeAppUser;
GO
