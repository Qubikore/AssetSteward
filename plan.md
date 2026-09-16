# Asset Management System - Project Plan

This document outlines the development plan for the **Asset Management System**, a centralized software solution for digitizing and managing the complete lifecycle of organizational assets.

## 1. Project Overview
- **Objective:** Provide a reliable, scalable platform for organizations to maintain accurate asset records, track ownership, and make data-driven decisions on utilization and maintenance.
- **Course:** Advanced Java Lab (CSE352.4) - Southeast University
- **Team Members:** Md. Mehedy Hasan, Md. Jakir Hossain, Ahnaf Sakil Mahmud

## 2. Technology Stack
- **Frontend:** Flutter / Dart (Cross-platform Android / iOS / Web)
- **Backend:** Spring Boot / Java
- **Database:** PostgreSQL
- **Architecture:** Client-Server RESTful API
- **Security:** JWT-based Authentication

## 3. Core Features & Implementation Phases

### Phase 1: Foundation & Security (Currently In Progress)
- [x] Spring Boot Project Setup
- [x] Database Connection (PostgreSQL)
- [x] User Entity & Role-Based Access Control (RBAC)
  - *Roles:* System Administrator (Super Admin), Asset Manager (HR), Department Manager, Employee (User)
- [x] JWT Authentication & Security Configuration
- [x] Profile Management with Multipart File Upload

### Phase 2: Core Asset Management
- [ ] **Asset Registration:** APIs to add new assets (Name, ID, Serial Number, Purchase Details, Vendor, Warranty, Location, Status).
- [ ] **Category & Location Management:** Managing departments, physical locations, and asset categories.
- [ ] **Asset Tracking:** Search and filter capabilities based on Category, Status, Location, Department, and Assigned Employee.

### Phase 3: Lifecycle & Assignment
- [ ] **Asset Assignment:** Assigning assets to employees, departments, or branches.
- [ ] **Asset Transfer:** Secure transferring of assets between entities.
- [ ] **Asset History Logging:** Preserving a timeline of events (Purchased → Available → Assigned → Maintenance → Returned → Retired).
- [ ] **Maintenance Management:** Recording maintenance requests, service dates, costs, and providers.

### Phase 4: Unique & Advanced Features
- [ ] **QR Code / Barcode Integration:** Generating unique QR codes for assets and enabling scanner-based identification via the Flutter app.
- [ ] **Dashboard & Reports:** Summarized metrics (Total, Available, Assigned, In-Maintenance, Retired assets) and utilization reports.
- [ ] **Smart Notifications:** Automated alerts for warranty expirations, scheduled maintenance, and overdue returns.
- [ ] **Utilization-Based Decision Support:** Analytics to identify unused or underutilized assets.

## 4. Entity Relationship Mapping
The backend will implement the following core entities as described in the ERD:
1. `ORGANIZATION`
2. `DEPARTMENT`
3. `LOCATION`
4. `CATEGORY`
5. `USER`
6. `ASSET`
7. `ASSIGNMENT`
8. `MAINTENANCE`
9. `ASSET_HISTORY`

## 5. Next Steps
1. Create JPA Entities for `Category`, `Location`, and `Department`.
2. Create JPA Entity for `Asset` with appropriate relationships.
3. Build the REST Controllers and Services for Asset CRUD operations.
4. Set up the Flutter project inside the `AssetStewardFrontend` directory and begin UI development.
