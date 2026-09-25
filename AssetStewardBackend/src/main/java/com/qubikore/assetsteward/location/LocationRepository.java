package com.qubikore.assetsteward.location;

import org.springframework.data.jpa.repository.JpaRepository;

public interface LocationRepository extends JpaRepository<Location, Long> {
    java.util.List<Location> findByOrganization(com.qubikore.assetsteward.user.Organization organization);

}
