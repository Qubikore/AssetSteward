package com.qubikore.assetsteward.user;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByEmail(String email);
    java.util.List<User> findByOrganization(Organization organization);
}
