/* ============================================================
   View: vw_OrderDetails
   Beschreibung:
   Zeigt Bestellungen inkl. Kunden- und Mitarbeiternamen.
   (INNER JOIN – Pflichtanforderung)
   ============================================================ */

CREATE VIEW dbo.vw_OrderDetails AS
SELECT 
    O.OrderID,
    O.OrderDate,
    O.FinalAmount,
    C.FirstName + ' ' + C.LastName AS CustomerName,
    E.FirstName + ' ' + E.LastName AS EmployeeName
FROM dbo.[Order] O
INNER JOIN dbo.Customer C 
    ON O.CustomerID = C.CustomerID
INNER JOIN dbo.Employee E 
    ON O.EmployeeID = E.EmployeeID;
GO
