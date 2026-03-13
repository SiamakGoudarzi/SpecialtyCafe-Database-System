/* ============================================================
   View: vw_EmployeePerformance
   Beschreibung:
   Umsatzstatistik pro Mitarbeiter.
   (GROUP BY + HAVING – Pflichtanforderung)
   ============================================================ */

CREATE VIEW dbo.vw_EmployeePerformance AS
SELECT 
    E.LastName,
    SUM(O.FinalAmount) AS TotalRevenue
FROM dbo.Employee E
JOIN dbo.[Order] O 
    ON E.EmployeeID = O.EmployeeID
GROUP BY E.LastName
HAVING SUM(O.FinalAmount) > 0;
GO
