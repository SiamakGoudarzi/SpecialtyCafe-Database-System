USE [CafeCRM_DB]
GO

/****** Object:  StoredProcedure [dbo].[usp_CreateNewOrder]    Script Date: 12.03.2026 11:20:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-------------------------------------------------------
-- 7. STORED PROCEDURE MIT BUSINESS-LOGIK
-------------------------------------------------------
Alter PROCEDURE [dbo].[usp_CreateNewOrder]
    @CID INT,
    @EID INT,
    @PID INT,
    @Qty INT,
    @ResultMsg NVARCHAR(100) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE 
        @UnitPrice DECIMAL(10,2),
        @Discount DECIMAL(5,2),
        @FinalPrice DECIMAL(12,2),
        @OrderID INT;

    -- 1. Bestandsprüfung
    IF NOT EXISTS(SELECT 1 FROM Inventory WHERE ProductID = @PID AND QuantityInStock >= @Qty)
    BEGIN
        SET @ResultMsg = 'Abbruch: Lagerbestand nicht ausreichend.';
        RETURN;
    END

    -- 2. Produktpreis
    SELECT @UnitPrice = Price FROM Product WHERE ProductID = @PID;

    -- 3. Rabatt
    SET @Discount = dbo.fn_GetDiscountRate(@CID);

    -- 4. Endbetrag
    SET @FinalPrice = (@UnitPrice * @Qty) * (1 - (@Discount / 100));
    


    -- 5. Eine Bestellung anlegen
    INSERT INTO [Order] (CustomerID, EmployeeID, TotalAmount, FinalAmount)
    VALUES (@CID, @EID, @UnitPrice * @Qty, @FinalPrice);

    -- Neue Bestellnummer abrufen
    SET @OrderID = SCOPE_IDENTITY();

    -- 6. OrderItem erstellen
    INSERT INTO OrderItem (OrderID, ProductID, Quantity, UnitPrice)
    VALUES (@OrderID, @PID, @Qty, @UnitPrice);

    -- 7. Kundenpunkte erhöhen
    UPDATE Customer 
    SET TotalPoints = TotalPoints + dbo.fn_CalcLoyaltyPoints(@FinalPrice)
    WHERE CustomerID = @CID;

    SET @ResultMsg = 'Erfolg: Bestellung + OrderItem erfolgreich erstellt.';
END
GO


