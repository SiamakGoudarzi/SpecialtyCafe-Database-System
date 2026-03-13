/* ============================================================
   Skalarfunktion: fn_GetDiscountRate
   Beschreibung:
   Gibt den Rabattprozentsatz eines Kunden basierend auf
   seinem Loyalty-Level zurück.
   ============================================================ */

CREATE FUNCTION dbo.fn_GetDiscountRate (@CustomerID INT)
RETURNS DECIMAL(5,2)
AS
BEGIN
    DECLARE @Rate DECIMAL(5,2);

    SELECT @Rate = L.DiscountPercent
    FROM Customer C
    JOIN LoyaltyLevel L ON C.LoyaltyLevelID = L.LoyaltyLevelID
    WHERE C.CustomerID = @CustomerID;

    RETURN ISNULL(@Rate, 0);
END;
GO
