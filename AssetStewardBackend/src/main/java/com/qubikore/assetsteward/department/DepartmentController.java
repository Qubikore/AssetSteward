package com.qubikore.assetsteward.department;

import com.qubikore.assetsteward.common.dto.ApiResponse;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/departments")
@SecurityRequirement(name = "Bearer Authentication")
public class DepartmentController {

    private final DepartmentService departmentService;

    public DepartmentController(DepartmentService departmentService) {
        this.departmentService = departmentService;
    }

    @Operation(summary = "Get all departments")
    @GetMapping
    public ResponseEntity<ApiResponse<List<DepartmentResponse>>> getAllDepartments(@org.springframework.security.core.annotation.AuthenticationPrincipal com.qubikore.assetsteward.user.User currentUser) {
        return ResponseEntity.ok(ApiResponse.success("Departments fetched successfully", departmentService.getAllDepartments(currentUser)));
    }

    @Operation(summary = "Get a department by ID")
    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<DepartmentResponse>> getDepartmentById(@PathVariable Long id) {
        return ResponseEntity.ok(ApiResponse.success("Department fetched successfully", departmentService.getDepartmentById(id)));
    }

    @Operation(summary = "Create a department")
    @PostMapping
    public ResponseEntity<ApiResponse<DepartmentResponse>> createDepartment(@RequestBody DepartmentRequest request, @org.springframework.security.core.annotation.AuthenticationPrincipal com.qubikore.assetsteward.user.User currentUser) {
        return ResponseEntity.ok(ApiResponse.success("Department created successfully", departmentService.createDepartment(request, currentUser)));
    }

    @Operation(summary = "Update a department")
    @PutMapping("/{id}")
    public ResponseEntity<ApiResponse<DepartmentResponse>> updateDepartment(@PathVariable Long id, @RequestBody DepartmentRequest request) {
        return ResponseEntity.ok(ApiResponse.success("Department updated successfully", departmentService.updateDepartment(id, request)));
    }

    @Operation(summary = "Delete a department")
    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteDepartment(@PathVariable Long id) {
        departmentService.deleteDepartment(id);
        return ResponseEntity.ok(ApiResponse.success("Department deleted successfully", null));
    }
}
