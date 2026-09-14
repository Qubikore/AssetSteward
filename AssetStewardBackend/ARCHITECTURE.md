# AssetSteward Architecture

## Overview
This project follows an **Industry-Standard Feature-First (Package-by-Feature) Architecture** along with the **Model-View-Controller (MVC)** design pattern.

## Feature-First Architecture
Instead of grouping files by their type (e.g., all controllers together, all services together), we group them by the **feature** they belong to. This approach has several benefits:
- **High Cohesion:** Everything related to a single feature is in one place.
- **Modularity:** Features are self-contained and less tightly coupled.
- **Scalability:** As the project grows, it is much easier to navigate and maintain.

## Project Structure
```text
src/main/java/com/qubikore/assetsteward/
├── AssetStewardApplication.java        # Main Spring Boot Entry Point
├── asset/                              # Feature: Asset Management
│   ├── Asset.java                      # Model (JPA Entity)
│   ├── AssetDTO.java                   # Data Transfer Object
│   ├── AssetRepository.java            # Data Access Layer (Spring Data JPA)
│   ├── AssetService.java               # Service Interface (Business Logic)
│   ├── AssetServiceImpl.java           # Service Implementation
│   └── AssetController.java            # Web MVC Controller (REST APIs)
└── common/                             # Cross-Cutting Concerns
    └── exception/                      # Global Exception Handling
        ├── GlobalExceptionHandler.java # Controller Advice for generic error mapping
        └── ResourceNotFoundException.java # Custom Exceptions
```

## Layers (MVC)
Within each feature module, we strictly adhere to the MVC and layered architectural pattern:
- **Controller Layer (`*Controller.java`):** Handles HTTP requests, validates input using DTOs, and delegates business logic to the Service layer.
- **Service Layer (`*Service.java`):** Contains all the business rules. It acts as an intermediary between the Controller and the Repository.
- **Data Access Layer (`*Repository.java`):** Interacts with the database. We use Spring Data JPA for boilerplate-free data access.
- **Domain Layer (`*.java` Entity):** The core business models mapped to database tables.

## Tech Stack Added
- **Spring Web:** For RESTful MVC architecture.
- **Spring Data JPA:** For database interactions.
- **Validation:** For checking constraints on DTOs.
- **H2 Database:** In-memory DB configured for quick development & testing (can be easily swapped to PostgreSQL/MySQL in `application.properties`).
