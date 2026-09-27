package com.qubikore.assetsteward.department;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class DepartmentService {

    private final DepartmentRepository departmentRepository;

    public DepartmentService(DepartmentRepository departmentRepository) {
        this.departmentRepository = departmentRepository;
    }

    public List<DepartmentResponse> getAllDepartments(com.qubikore.assetsteward.user.User currentUser) {
        return departmentRepository.findByOrganization(currentUser.getOrganization()).stream()
                .map(DepartmentResponse::new)
                .collect(Collectors.toList());
    }

    public DepartmentResponse getDepartmentById(Long id) {
        Department department = departmentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Department not found"));
        return new DepartmentResponse(department);
    }

    public DepartmentResponse createDepartment(DepartmentRequest request, com.qubikore.assetsteward.user.User currentUser) {
        if (departmentRepository.existsByNameAndOrganization(request.getName(), currentUser.getOrganization())) {
            throw new RuntimeException("Department already exists");
        }
        Department department = new Department(request.getName());
        department.setOrganization(currentUser.getOrganization());

        department = departmentRepository.save(department);
        return new DepartmentResponse(department);
    }

    public DepartmentResponse updateDepartment(Long id, DepartmentRequest request) {
        Department department = departmentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Department not found"));
        
        if (!department.getName().equals(request.getName()) && departmentRepository.existsByNameAndOrganization(request.getName(), department.getOrganization())) {
            throw new RuntimeException("Department already exists");
        }

        department.setName(request.getName());
        department = departmentRepository.save(department);
        return new DepartmentResponse(department);
    }

    public void deleteDepartment(Long id) {
        Department department = departmentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Department not found"));
        departmentRepository.delete(department);
    }
}
