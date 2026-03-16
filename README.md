# Café Teheran to Tokyo – CRM & Database Architecture

## Project Context / Projektkontext
**English:** This repository is the technical realization of the "Café Teheran to Tokyo" CRM system. It transforms strategic business analysis into a robust SQL Server database. This implementation covers the full lifecycle from business logic to database automation.
🔗 **Link to Strategic Analysis:** [CRM-Strategy-Portfolio](https://github.com/SiamakGoudarzi/CRM-Strategy-Portfolio/tree/main/01-Teheran-to-Tokyo-Cafe)

**Deutsch:** Dieses Repository ist die technische Umsetzung des CRM-Systems für das "Café Teheran to Tokyo". Es transformiert die strategische Geschäftsanalyse in eine robuste SQL Server-Datenbank. Diese Implementierung deckt den gesamten Lebenszyklus von der Geschäftslogik bis zur Datenbankautomatisierung ab.
🔗 **Link zur strategischen Analyse:** [CRM-Strategy-Portfolio](https://github.com/SiamakGoudarzi/CRM-Strategy-Portfolio/tree/main/01-Teheran-to-Tokyo-Cafe)

---

## 📂 Repository Structure / Repository-Struktur

### 01-Documentation
- `009-Dokumentation.pdf`: Full project report containing system analysis and requirements.
- `010-CafeCRMDiagramm.pdf`: Technical architecture and UML diagrams.

### 02-SQL-Scripts
- `001-DB-Create-Scripts.sql`: Database schema, tables, and constraints.
- `002-Views.sql`: Management reports and data visualizations.
- `003-Functions.sql`: Scalar and table-valued functions for discount and points.
- `004-Procedures.sql`: Stored procedure for the complete order transaction.
- `005-Triggers.sql`: Automation for inventory management and loyalty status.
- `006-Security-Setup.sql`: RBAC implementation and `CafeAppUser` configuration.

### 03-Diagrams
- `ERD-Diagram.png`: Entity Relationship Diagram for visual database overview.

### 04-Test-Protocols
- `008-Tests.sql`: 9-step validation script covering all business rules and integrity tests.

---

## Key Features / Technische Highlights

### 🇬🇧 English
- **Automated Inventory:** Real-time stock reduction via triggers after every validated sale.
- **Dynamic Loyalty Program:** Multi-level status upgrades (Bronze/Silver/Gold) based on automated point calculations.
- **Employee Performance (KPI):** Automated scoring system for Baristas based on transaction volume and speed.
- **Advanced Security:** Role-Based Access Control (RBAC) ensuring data integrity and preventing unauthorized schema changes.

### 🇩🇪 Deutsch
- **Automatisierte Lagerhaltung:** Echtzeit-Bestandsabbuchung durch Trigger nach jedem validierten Verkauf.
- **Dynamisches Treueprogramm:** Mehrstufige Status-Upgrades (Bronze/Silber/Gold) basierend auf automatisierten Punkteberechnungen.
- **Mitarbeiter-Performance (KPI):** Automatisiertes Bewertungssystem für Baristas basierend auf Umsatz und Transaktionsgeschwindigkeit.
- **Erweiterte Sicherheit:** Rollenbasierte Zugriffskontrolle (RBAC) zur Gewährleistung der Datenintegrität und zur Verhinderung unbefugter Schemaänderungen.

---

## Validation & Testing / Validierung & Tests

**English:** The system has been verified through a **9-step testing protocol** included in folder `/04-Test-Protocols`. These tests ensure that triggers, procedures, and cascading deletes function correctly under production-like scenarios.

**Deutsch:** Das System wurde durch ein **9-stufiges Testprotokoll** verifiziert (zu finden im Ordner `/04-Test-Protocols`). Diese Tests stellen sicher, dass Trigger, Prozeduren und kaskadierende Löschvorgänge in produktionsnahen Szenarien korrekt funktionieren.

---
**Developed by:** Siamak Goudarzi  
**Project:** Premium CRM Database for "Teheran to Tokyo" Café Berlin.

---

## ⚖️ License / Lizenz
**English:** This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

**Deutsch:** Dieses Projekt ist unter der **MIT-Lizenz** lizenziert - siehe die [LICENSE](LICENSE)-Datei für Details.
