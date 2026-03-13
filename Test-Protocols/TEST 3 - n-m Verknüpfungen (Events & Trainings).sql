/* TEST 3: n:m Verknüpfungen (Events & Trainings)
   Ziel: Nachweis der korrekten Implementierung von Mapping-Tabellen.
*/

-- Abfrage: Welche Kunden nehmen an welchen kulturellen Events teil?
SELECT C.FirstName, C.LastName, E.EventName, E.Location
FROM CustomerEvent CE
JOIN Customer C ON CE.CustomerID = C.CustomerID
JOIN CafeEvent E ON CE.EventID = E.EventID
ORDER BY E.EventDate;

-- Abfrage: Welche Mitarbeiter haben welche SCA-Schulungen absolviert?
SELECT E.LastName AS Barista, T.TrainingName
FROM EmployeeTraining ET
JOIN Employee E ON ET.EmployeeID = E.EmployeeID
JOIN Training T ON ET.TrainingID = T.TrainingID;
GO