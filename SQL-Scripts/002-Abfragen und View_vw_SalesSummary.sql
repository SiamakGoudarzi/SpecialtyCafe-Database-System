/* ============================================================
   View: vw_SalesSummary
   Beschreibung:
   Zeigt eine Verkaufsübersicht inkl. Kunden- und Baristanamen.
   (INNER JOIN – Pflichtanforderung laut Projektbeschreibung)
   ============================================================ */

CREATE VIEW dbo.vw_SalesSummary AS
SELECT 
    O.OrderID,
    O.OrderDate,
    C.LastName AS Customer,
    E.LastName AS Barista,
    O.FinalAmount
FROM dbo.[Order] O
INNER JOIN dbo.Customer C 
    ON O.CustomerID = C.CustomerID
INNER JOIN dbo.Employee E 
    ON O.EmployeeID = E.EmployeeID;
GO
