-- Aktualisiert das Loyalty-Level automatisch nach Punkteänderung
CREATE TRIGGER trg_CheckLoyaltyUpgrade
ON Customer
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE C
    SET LoyaltyLevelID = L.LoyaltyLevelID
    FROM Customer C
    JOIN LoyaltyLevel L 
        ON C.TotalPoints >= L.MinPoints
    WHERE C.CustomerID IN (SELECT CustomerID FROM inserted);
END;
