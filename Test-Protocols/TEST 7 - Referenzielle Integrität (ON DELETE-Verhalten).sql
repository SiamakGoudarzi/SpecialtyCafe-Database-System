/* TEST 7: Referenzielle Integrität (ON DELETE-Verhalten)
   Ziel: Prüfung, ob das Löschen eines Auftrags die verknüpften 
   Positionen korrekt behandelt (CASCADE oder SET NULL).
*/

-- Prüfung der verknüpften Posten vor dem Löschen
SELECT * FROM OrderItem WHERE OrderID = 130;

-- Versuch, einen Auftrag zu löschen
DELETE FROM [Order] WHERE OrderID = 130;

-- Kontrolle: Sind die OrderItems noch da oder mitgelöscht?
SELECT * FROM OrderItem WHERE OrderID = 130;
GO
