# API Routes for Postman Testing

Base URL: `http://localhost:8080` (or your configured `app.backend-url`)
All endpoints may require an Authorization header (e.g., `Authorization: Bearer <token>`) depending on your security setup.

---

## 1. Categories (`/api/v1/categories`)
* **ID Type:** `Long` (e.g., `1`)

| Method | Endpoint | Content-Type | Description |
| :--- | :--- | :--- | :--- |
| **POST** | `/api/v1/categories` | `multipart/form-data` | Create a new category. <br> **Fields**: `name` (text, required), `description` (text, optional), `icon` (file, optional). |
| **GET** | `/api/v1/categories` | None | Get a list of all categories. |
| **GET** | `/api/v1/categories/{id}` | None | Get a specific category by ID. |
| **POST** / **PUT** | `/api/v1/categories/{id}` | `multipart/form-data` | Update a category (use `POST` to safely upload files). <br> **Fields**: `name`, `description`, `icon`. |
| **DELETE** | `/api/v1/categories/{id}` | None | Delete a category by ID. |

---

## 2. Assets (`/api/v1/assets`)
* **ID Type:** `UUID` (e.g., `550e8400-e29b-41d4-a716-446655440000`)

| Method | Endpoint | Content-Type | Description |
| :--- | :--- | :--- | :--- |
| **POST** | `/api/v1/assets` | `application/json` | Create a new asset. <br> **Body**:<br> `{"itemName": "MacBook Pro 16", "categoryId": 1, "userId": 1, "brand": "Apple", "modelNumber": "A2485", "serialNumber": "C02F123456", "purchasePrice": 2499.99, "purchaseDate": "2023-11-15", "warrantyMonths": 24, "warrantyExpiryDate": "2025-11-15", "currentEstimatedValue": 2100.00, "location": "Headquarters - IT Room"}` |
| **GET** | `/api/v1/assets` | None | Get a list of all assets. |
| **GET** | `/api/v1/assets/{id}` | None | Get a specific asset by UUID. |
| **PUT** | `/api/v1/assets/{id}` | `application/json` | Update an asset. <br> **Body**: JSON with any of the fields above you want to change. |
| **DELETE** | `/api/v1/assets/{id}` | None | Delete an asset by UUID. |

---

## 3. Documents (`/api/v1/documents`)
* **ID Type:** `UUID`

| Method | Endpoint | Content-Type | Description |
| :--- | :--- | :--- | :--- |
| **POST** | `/api/v1/documents` | `multipart/form-data` | Upload a document for an asset. <br> **Fields**: `assetId` (UUID, required), `documentType` (text), `extractedText` (text), `file` (file). |
| **GET** | `/api/v1/documents/{id}` | None | Get a document by UUID. |
| **GET** | `/api/v1/documents/asset/{assetId}` | None | Get all documents associated with a specific asset UUID. |
| **POST** / **PUT** | `/api/v1/documents/{id}`| `multipart/form-data` | Update a document. (Use `POST` if replacing the file). |
| **DELETE** | `/api/v1/documents/{id}` | None | Delete a document by UUID. |

---

## 4. Maintenance Logs (`/api/v1/maintenance-logs`)
* **ID Type:** `UUID`

| Method | Endpoint | Content-Type | Description |
| :--- | :--- | :--- | :--- |
| **POST** | `/api/v1/maintenance-logs` | `application/json` | Create a maintenance log. <br> **Body**: <br> `{"assetId": "550e8400-e29b-41d4-a716-446655440000", "serviceDate": "2024-05-20", "description": "Annual battery replacement and screen cleaning.", "cost": 150.00, "performedBy": "John Doe - IT Support", "isRecurring": true, "nextDueDate": "2025-05-20"}` |
| **GET** | `/api/v1/maintenance-logs/{id}` | None | Get a maintenance log by UUID. |
| **GET** | `/api/v1/maintenance-logs/asset/{assetId}` | None | Get all maintenance logs associated with a specific asset UUID. |
| **PUT** | `/api/v1/maintenance-logs/{id}` | `application/json` | Update a maintenance log. <br> **Body**: JSON with any of the fields above you want to change. |
| **DELETE** | `/api/v1/maintenance-logs/{id}` | None | Delete a maintenance log by UUID. |
