/* ============================================================
   Tabellenwertfunktion: fn_InventoryAlert
   Beschreibung:
   Gibt alle Produkte zurück, deren Lagerbestand unter dem
   definierten MinimumStock liegt.
   ============================================================ */

CREATE FUNCTION dbo.fn_InventoryAlert()
RETURNS TABLE
AS
RETURN
(
    SELECT 
        P.ProductID,
        P.ProductName,
        I.QuantityInStock,
        I.MinimumStock,
        S.SupplierName
    FROM Inventory I
    JOIN Product P ON I.ProductID = P.ProductID
    LEFT JOIN Supplier S ON I.SupplierID = S.SupplierID
    WHERE I.QuantityInStock < I.MinimumStock
);
GO
