# Asset Steward AI Guidelines

## Response System
All REST Controllers MUST use the default response system wrapper `ApiResponse<T>` from `com.qubikore.assetsteward.common.dto.ApiResponse`.

### Example
```java
@GetMapping("/{id}")
public ResponseEntity<ApiResponse<UserDTO>> getUserById(@PathVariable Long id) {
    UserDTO user = userService.getUserById(id);
    return ResponseEntity.ok(ApiResponse.success("User retrieved successfully", user));
}
```

Never return raw DTOs or Entities directly from controllers. Always wrap them in `ApiResponse.success(message, data)` or `ApiResponse.error(status, message)`.

## Image Links
When returning image URLs or paths in responses, always construct the full URL by prefixing the relative path with the backend URL from the `.env` configuration.
Use `@Value("${app.backend-url:http://localhost:8080}")` to inject the backend URL into your services.

### Example
```java
if (entity.getImagePath() != null && !entity.getImagePath().startsWith("http")) {
    dto.setImageUrl(backendUrl + entity.getImagePath());
}
```
