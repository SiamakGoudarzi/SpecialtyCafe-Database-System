/* TEST 8: Skalarfunktion 'fn_GetDiscountRate'
   Ziel: Prüfung, ob ein VIP-Kunde den korrekten Rabattsatz erhält.
*/

DECLARE @Discount DECIMAL(5,2);
-- Annahme: Kunde 5 ist ein VIP-Kunde
SET @Discount = dbo.fn_GetDiscountRate(11);

PRINT 'Der Rabattsatz für diesen Kunden beträgt: ' + CAST(@Discount AS NVARCHAR) + '%';
-- Erwartung: Ein Wert entsprechend der Definition (z.B. 15.00%).
GO
