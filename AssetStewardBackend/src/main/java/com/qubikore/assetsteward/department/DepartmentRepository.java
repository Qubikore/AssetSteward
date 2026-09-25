package com.qubikore.assetsteward.department;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DepartmentRepository extends JpaRepository<Department, Long> {
    boolean existsByNameAndOrganization(String name, com.qubikore.assetsteward.user.Organization organization);
    java.util.List<Department> findByOrganization(com.qubikore.assetsteward.user.Organization organization);

}
