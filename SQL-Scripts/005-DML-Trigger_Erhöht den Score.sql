-- Erhöht den Score des Mitarbeiters nach einer neuen Bestellung
CREATE TRIGGER trg_UpdateEmployeeKPI
ON [Order]
AFTER INSERT
AS
BEGIN
    -- Score um 1 erhöhen
    UPDATE EmployeeKPI
    SET Score = Score + 1
    FROM EmployeeKPI k
    INNER JOIN inserted i ON k.EmployeeID = i.EmployeeID;
END;
