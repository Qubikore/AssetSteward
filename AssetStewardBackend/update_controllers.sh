#!/bin/bash
# CategoryController
sed -i '' 's/public ResponseEntity<ApiResponse<List<CategoryResponse>>> getAllCategories()/public ResponseEntity<ApiResponse<List<CategoryResponse>>> getAllCategories(@org.springframework.security.core.annotation.AuthenticationPrincipal com.qubikore.assetsteward.user.User currentUser)/g' src/main/java/com/qubikore/assetsteward/category/CategoryController.java
sed -i '' 's/categoryService.getAllCategories()/categoryService.getAllCategories(currentUser)/g' src/main/java/com/qubikore/assetsteward/category/CategoryController.java
sed -i '' 's/public ResponseEntity<ApiResponse<CategoryResponse>> createCategory(@RequestBody CategoryRequest request)/public ResponseEntity<ApiResponse<CategoryResponse>> createCategory(@RequestBody CategoryRequest request, @org.springframework.security.core.annotation.AuthenticationPrincipal com.qubikore.assetsteward.user.User currentUser)/g' src/main/java/com/qubikore/assetsteward/category/CategoryController.java
sed -i '' 's/categoryService.createCategory(request)/categoryService.createCategory(request, currentUser)/g' src/main/java/com/qubikore/assetsteward/category/CategoryController.java

# DepartmentController
sed -i '' 's/public ResponseEntity<ApiResponse<List<DepartmentResponse>>> getAllDepartments()/public ResponseEntity<ApiResponse<List<DepartmentResponse>>> getAllDepartments(@org.springframework.security.core.annotation.AuthenticationPrincipal com.qubikore.assetsteward.user.User currentUser)/g' src/main/java/com/qubikore/assetsteward/department/DepartmentController.java
sed -i '' 's/departmentService.getAllDepartments()/departmentService.getAllDepartments(currentUser)/g' src/main/java/com/qubikore/assetsteward/department/DepartmentController.java
sed -i '' 's/public ResponseEntity<ApiResponse<DepartmentResponse>> createDepartment(@RequestBody DepartmentRequest request)/public ResponseEntity<ApiResponse<DepartmentResponse>> createDepartment(@RequestBody DepartmentRequest request, @org.springframework.security.core.annotation.AuthenticationPrincipal com.qubikore.assetsteward.user.User currentUser)/g' src/main/java/com/qubikore/assetsteward/department/DepartmentController.java
sed -i '' 's/departmentService.createDepartment(request)/departmentService.createDepartment(request, currentUser)/g' src/main/java/com/qubikore/assetsteward/department/DepartmentController.java

# LocationController
sed -i '' 's/public ResponseEntity<ApiResponse<List<LocationResponse>>> getAllLocations()/public ResponseEntity<ApiResponse<List<LocationResponse>>> getAllLocations(@org.springframework.security.core.annotation.AuthenticationPrincipal com.qubikore.assetsteward.user.User currentUser)/g' src/main/java/com/qubikore/assetsteward/location/LocationController.java
sed -i '' 's/locationService.getAllLocations()/locationService.getAllLocations(currentUser)/g' src/main/java/com/qubikore/assetsteward/location/LocationController.java
sed -i '' 's/public ResponseEntity<ApiResponse<LocationResponse>> createLocation(@RequestBody LocationRequest request)/public ResponseEntity<ApiResponse<LocationResponse>> createLocation(@RequestBody LocationRequest request, @org.springframework.security.core.annotation.AuthenticationPrincipal com.qubikore.assetsteward.user.User currentUser)/g' src/main/java/com/qubikore/assetsteward/location/LocationController.java
sed -i '' 's/locationService.createLocation(request)/locationService.createLocation(request, currentUser)/g' src/main/java/com/qubikore/assetsteward/location/LocationController.java
