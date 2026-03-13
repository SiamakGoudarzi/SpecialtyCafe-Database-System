/* TEST 2: Transaktionslogik & Automatisierung
   Ziel: Test von 'usp_CreateNewOrder' in Verbindung mit dem Lager-Trigger.
*/

-- 1. Status vor der Transaktion (Beispiel: Kunde 1, Produkt 1)
SELECT TotalPoints AS 'Punkte Vorher' FROM Customer WHERE CustomerID = 1;
SELECT QuantityInStock AS 'Lager Vorher' FROM Inventory WHERE ProductID = 1;

-- 2. Durchführung einer Test-Bestellung
DECLARE @Msg NVARCHAR(100);
EXEC dbo.usp_CreateNewOrder 
    @CID = 1, @EID = 1, @PID = 1, @Qty = 10, 
    @ResultMsg = @Msg OUTPUT;
PRINT 'System-Feedback: ' + @Msg;

-- 3. Status nach der Transaktion
SELECT TotalPoints AS 'Punkte Nachher' FROM Customer WHERE CustomerID = 1;
SELECT QuantityInStock AS 'Lager Nachher' FROM Inventory WHERE ProductID = 1;
-- Erwartung: Punkte gestiegen, Lager um 10 Einheiten gesunken.
GO