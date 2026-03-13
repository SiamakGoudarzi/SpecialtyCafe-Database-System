/* ============================================================
   Skalarfunktion: fn_CalcLoyaltyPoints
   Beschreibung:
   Rechnet den Umsatz eines Kunden in Treuepunkte um.
   Beispiel: 10 € = 1 Punkt
   ============================================================ */

CREATE FUNCTION dbo.fn_CalcLoyaltyPoints (@Amount DECIMAL(12,2))
RETURNS INT
AS
BEGIN
    RETURN FLOOR(@Amount / 10);
END;
GO
