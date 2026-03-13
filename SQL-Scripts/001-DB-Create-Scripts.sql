/* ============================================================
   Projekt: CaféCRM_DB
   Abschnitt: Datenbank- und Tabellen-Erstellung
   Autor: Siamak Goudarzi & Mahsa Saeedzadeh
   Datum: 12.03.2026
   Beschreibung:
   Dieses Skript erstellt die Datenbank sowie alle Tabellen,
   Primärschlüssel, Fremdschlüssel, Default- und Check-Constraints
   und einen Nonclustered Index.
   ============================================================ */

---------------------------------------------------------------
-- 1) Datenbank erstellen
---------------------------------------------------------------
CREATE DATABASE CafeCRM_DB;
GO

USE CafeCRM_DB;
GO


/* ============================================================
   2) Tabellen erstellen
   ============================================================ */

---------------------------------------------------------------
-- Tabelle: Product
---------------------------------------------------------------
CREATE TABLE dbo.Product (
    ProductID      INT IDENTITY(1,1) NOT NULL,
    ProductName    NVARCHAR(100)     NOT NULL,
    CategoryID     INT               NULL,
    Price          DECIMAL(10,2)     NOT NULL,
    IsActive       BIT               NOT NULL CONSTRAINT DF_Product_IsActive DEFAULT (1),
    CONSTRAINT PK_Product PRIMARY KEY (ProductID),
    CONSTRAINT CHK_ProductPrice CHECK (Price > 0)
);
GO


---------------------------------------------------------------
-- Tabelle: Supplier
---------------------------------------------------------------
CREATE TABLE dbo.Supplier (
    SupplierID     INT IDENTITY(1,1) NOT NULL,
    SupplierName   NVARCHAR(100)     NOT NULL,
    ContactEmail   NVARCHAR(100)     NULL,
    Phone          NVARCHAR(20)      NULL,
    City           VARCHAR(10)       NULL,
    Street         VARCHAR(20)       NULL,
    ZipCode        NCHAR(10)         NULL,
    CONSTRAINT PK_Supplier PRIMARY KEY (SupplierID)
);
GO


---------------------------------------------------------------
-- Tabelle: Inventory
---------------------------------------------------------------
CREATE TABLE dbo.Inventory (
    InventoryID      INT IDENTITY(1,1) NOT NULL,
    ProductID        INT               NULL,
    QuantityInStock  INT               NOT NULL,
    MinimumStock     INT               NOT NULL CONSTRAINT DF_Inventory_MinStock DEFAULT (10),
    SupplierID       INT               NULL,
    CONSTRAINT PK_Inventory PRIMARY KEY (InventoryID),
    CONSTRAINT CHK_InventoryQty CHECK (QuantityInStock >= 0)
);
GO


---------------------------------------------------------------
-- Tabelle: Customer
---------------------------------------------------------------
CREATE TABLE dbo.Customer (
    CustomerID        INT IDENTITY(1,1) NOT NULL,
    FirstName         NVARCHAR(50)      NULL,
    LastName          NVARCHAR(50)      NULL,
    Email             NVARCHAR(100)     NULL,
    Phone             NVARCHAR(20)      NULL,
    RegistrationDate  DATETIME          NOT NULL CONSTRAINT DF_Customer_RegDate DEFAULT (GETDATE()),
    TotalPoints       INT               NOT NULL CONSTRAINT DF_Customer_Points DEFAULT (0),
    LoyaltyLevelID    INT               NULL,
    CONSTRAINT PK_Customer PRIMARY KEY (CustomerID),
    CONSTRAINT CHK_CustomerPoints CHECK (TotalPoints >= 0)
);
GO


---------------------------------------------------------------
-- Tabelle: Employee
---------------------------------------------------------------
CREATE TABLE dbo.Employee (
    EmployeeID    INT IDENTITY(1,1) NOT NULL,
    FirstName     NVARCHAR(50)      NULL,
    LastName      NVARCHAR(50)      NULL,
    Position      NVARCHAR(50)      NULL,
    HireDate      DATE              NOT NULL CONSTRAINT DF_Employee_HireDate DEFAULT (GETDATE()),
    Salary        DECIMAL(10,2)     NULL,
    Phone         VARCHAR(15)       NULL,
    City          VARCHAR(20)       NULL,
    Street        VARCHAR(50)       NULL,
    ZipCode       VARCHAR(10)       NULL,
    CONSTRAINT PK_Employee PRIMARY KEY (EmployeeID)
);
GO


---------------------------------------------------------------
-- Tabelle: Order
---------------------------------------------------------------
CREATE TABLE dbo.[Order] (
    OrderID        INT IDENTITY(1,1) NOT NULL,
    CustomerID     INT               NULL,
    EmployeeID     INT               NULL,
    OrderDate      DATETIME          NOT NULL CONSTRAINT DF_Order_Date DEFAULT (GETDATE()),
    TotalAmount    DECIMAL(12,2)     NULL,
    FinalAmount    DECIMAL(12,2)     NULL,
    PaymentMethod  NVARCHAR(50)      NULL,
    CONSTRAINT PK_Order PRIMARY KEY (OrderID)
);
GO


---------------------------------------------------------------
-- Tabelle: OrderItem
---------------------------------------------------------------
CREATE TABLE dbo.OrderItem (
    OrderItemID   INT IDENTITY(1,1) NOT NULL,
    OrderID       INT               NULL,
    ProductID     INT               NULL,
    Quantity      INT               NOT NULL,
    UnitPrice     DECIMAL(10,2)     NULL,
    CONSTRAINT PK_OrderItem PRIMARY KEY (OrderItemID),
    CONSTRAINT CHK_OrderItem_Qty CHECK (Quantity > 0)
);
GO


---------------------------------------------------------------
-- Tabelle: LoyaltyLevel
---------------------------------------------------------------
CREATE TABLE dbo.LoyaltyLevel (
    LoyaltyLevelID   INT IDENTITY(1,1) NOT NULL,
    LevelName        NVARCHAR(20)      NOT NULL,
    MinPoints        INT               NOT NULL,
    DiscountPercent  DECIMAL(5,2)      NOT NULL CONSTRAINT DF_Loyalty_Discount DEFAULT (0),
    CONSTRAINT PK_Loyalty PRIMARY KEY (LoyaltyLevelID),
    CONSTRAINT CHK_MinPoints CHECK (MinPoints >= 0)
);
GO


---------------------------------------------------------------
-- Tabelle: ProductCategory
---------------------------------------------------------------
CREATE TABLE dbo.ProductCategory (
    CategoryID    INT IDENTITY(1,1) NOT NULL,
    CategoryName  NVARCHAR(50)      NOT NULL,
    CONSTRAINT PK_Category PRIMARY KEY (CategoryID)
);
GO


---------------------------------------------------------------
-- Tabelle: CafeEvent
---------------------------------------------------------------
CREATE TABLE dbo.CafeEvent (
    EventID     INT IDENTITY(1,1) NOT NULL,
    EventName   NVARCHAR(100)     NULL,
    EventDate   DATE              NULL,
    Location    NVARCHAR(100)     NULL,
    CONSTRAINT PK_Event PRIMARY KEY (EventID)
);
GO


---------------------------------------------------------------
-- Tabelle: CustomerEvent (n:m)
---------------------------------------------------------------
CREATE TABLE dbo.CustomerEvent (
    CustomerID  INT NOT NULL,
    EventID     INT NOT NULL,
    CONSTRAINT PK_CustomerEvent PRIMARY KEY (CustomerID, EventID)
);
GO


---------------------------------------------------------------
-- Tabelle: EmployeeKPI
---------------------------------------------------------------
CREATE TABLE dbo.EmployeeKPI (
    KPIID          INT IDENTITY(1,1) NOT NULL,
    EmployeeID     INT               NULL,
    SalesAmount    DECIMAL(12,2)     NULL,
    EvaluationDate DATE              NULL,
    Score          INT               NULL,
    CONSTRAINT PK_KPI PRIMARY KEY (KPIID),
    CONSTRAINT CHK_KPI_Score CHECK (Score BETWEEN 0 AND 100)
);
GO


---------------------------------------------------------------
-- Tabelle: Training
---------------------------------------------------------------
CREATE TABLE dbo.Training (
    TrainingID    INT IDENTITY(1,1) NOT NULL,
    TrainingName  NVARCHAR(100)     NULL,
    TrainingDate  DATE              NULL,
    CONSTRAINT PK_Training PRIMARY KEY (TrainingID)
);
GO


---------------------------------------------------------------
-- Tabelle: EmployeeTraining (n:m)
---------------------------------------------------------------
CREATE TABLE dbo.EmployeeTraining (
    EmployeeID  INT NOT NULL,
    TrainingID  INT NOT NULL,
    CONSTRAINT PK_EmployeeTraining PRIMARY KEY (EmployeeID, TrainingID)
);
GO


/* ============================================================
   3) Fremdschlüssel hinzufügen
   ============================================================ */

ALTER TABLE dbo.Product
ADD CONSTRAINT FK_Product_Category
    FOREIGN KEY (CategoryID) REFERENCES dbo.ProductCategory(CategoryID);

ALTER TABLE dbo.Inventory
ADD CONSTRAINT FK_Inventory_Product
    FOREIGN KEY (ProductID) REFERENCES dbo.Product(ProductID);

ALTER TABLE dbo.Inventory
ADD CONSTRAINT FK_Inventory_Supplier
    FOREIGN KEY (SupplierID) REFERENCES dbo.Supplier(SupplierID);

ALTER TABLE dbo.Customer
ADD CONSTRAINT FK_Customer_Loyalty
    FOREIGN KEY (LoyaltyLevelID) REFERENCES dbo.LoyaltyLevel(LoyaltyLevelID);

ALTER TABLE dbo.[Order]
ADD CONSTRAINT FK_Order_Customer
    FOREIGN KEY (CustomerID) REFERENCES dbo.Customer(CustomerID);

ALTER TABLE dbo.[Order]
ADD CONSTRAINT FK_Order_Employee
    FOREIGN KEY (EmployeeID) REFERENCES dbo.Employee(EmployeeID);

ALTER TABLE dbo.OrderItem
ADD CONSTRAINT FK_Item_Order
    FOREIGN KEY (OrderID) REFERENCES dbo.[Order](OrderID);

ALTER TABLE dbo.OrderItem
ADD CONSTRAINT FK_Item_Product
    FOREIGN KEY (ProductID) REFERENCES dbo.Product(ProductID);

ALTER TABLE dbo.CustomerEvent
ADD CONSTRAINT FK_CE_Customer
    FOREIGN KEY (CustomerID) REFERENCES dbo.Customer(CustomerID);

ALTER TABLE dbo.CustomerEvent
ADD CONSTRAINT FK_CE_Event
    FOREIGN KEY (EventID) REFERENCES dbo.CafeEvent(EventID);

ALTER TABLE dbo.EmployeeKPI
ADD CONSTRAINT FK_KPI_Employee
    FOREIGN KEY (EmployeeID) REFERENCES dbo.Employee(EmployeeID);

ALTER TABLE dbo.EmployeeTraining
ADD CONSTRAINT FK_ET_Employee
    FOREIGN KEY (EmployeeID) REFERENCES dbo.Employee(EmployeeID);

ALTER TABLE dbo.EmployeeTraining
ADD CONSTRAINT FK_ET_Training
    FOREIGN KEY (TrainingID) REFERENCES dbo.Training(TrainingID);
GO


/* ============================================================
   4) Nonclustered Index
   ============================================================ */

CREATE NONCLUSTERED INDEX IX_Order_OrderDate
ON dbo.[Order](OrderDate);
GO
