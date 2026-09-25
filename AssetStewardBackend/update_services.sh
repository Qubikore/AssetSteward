#!/bin/bash
# CategoryService
sed -i '' 's/getAllCategories()/getAllCategories(com.qubikore.assetsteward.user.User currentUser)/g' src/main/java/com/qubikore/assetsteward/category/CategoryService.java
sed -i '' 's/categoryRepository.findAll()/categoryRepository.findByOrganization(currentUser.getOrganization())/g' src/main/java/com/qubikore/assetsteward/category/CategoryService.java
sed -i '' 's/createCategory(CategoryRequest request)/createCategory(CategoryRequest request, com.qubikore.assetsteward.user.User currentUser)/g' src/main/java/com/qubikore/assetsteward/category/CategoryService.java
sed -i '' 's/existsByName(request.getName())/existsByNameAndOrganization(request.getName(), currentUser.getOrganization())/g' src/main/java/com/qubikore.assetsteward.category/CategoryService.java
sed -i '' '/Category category = new Category(request.getName());/a\
        category.setOrganization(currentUser.getOrganization());\
' src/main/java/com/qubikore/assetsteward/category/CategoryService.java

# DepartmentService
sed -i '' 's/getAllDepartments()/getAllDepartments(com.qubikore.assetsteward.user.User currentUser)/g' src/main/java/com/qubikore/assetsteward/department/DepartmentService.java
sed -i '' 's/departmentRepository.findAll()/departmentRepository.findByOrganization(currentUser.getOrganization())/g' src/main/java/com/qubikore/assetsteward/department/DepartmentService.java
sed -i '' 's/createDepartment(DepartmentRequest request)/createDepartment(DepartmentRequest request, com.qubikore.assetsteward.user.User currentUser)/g' src/main/java/com/qubikore/assetsteward/department/DepartmentService.java
sed -i '' 's/existsByName(request.getName())/existsByNameAndOrganization(request.getName(), currentUser.getOrganization())/g' src/main/java/com/qubikore.assetsteward.department/DepartmentService.java
sed -i '' '/Department department = new Department(request.getName());/a\
        department.setOrganization(currentUser.getOrganization());\
' src/main/java/com/qubikore/assetsteward/department/DepartmentService.java

# LocationService
sed -i '' 's/getAllLocations()/getAllLocations(com.qubikore.assetsteward.user.User currentUser)/g' src/main/java/com/qubikore/assetsteward/location/LocationService.java
sed -i '' 's/locationRepository.findAll()/locationRepository.findByOrganization(currentUser.getOrganization())/g' src/main/java/com/qubikore/assetsteward/location/LocationService.java
sed -i '' 's/createLocation(LocationRequest request)/createLocation(LocationRequest request, com.qubikore.assetsteward.user.User currentUser)/g' src/main/java/com/qubikore/assetsteward/location/LocationService.java
sed -i '' '/Location location = new Location(request.getName(), request.getAddress());/a\
        location.setOrganization(currentUser.getOrganization());\
' src/main/java/com/qubikore/assetsteward/location/LocationService.java
