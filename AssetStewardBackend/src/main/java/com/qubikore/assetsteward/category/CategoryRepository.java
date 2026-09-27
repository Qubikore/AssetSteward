package com.qubikore.assetsteward.category;

import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoryRepository extends JpaRepository<Category, Long> {
    boolean existsByNameAndOrganization(String name, com.qubikore.assetsteward.user.Organization organization);
    java.util.List<Category> findByOrganization(com.qubikore.assetsteward.user.Organization organization);

}
