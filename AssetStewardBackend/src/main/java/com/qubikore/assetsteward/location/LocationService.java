package com.qubikore.assetsteward.location;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class LocationService {

    private final LocationRepository locationRepository;

    public LocationService(LocationRepository locationRepository) {
        this.locationRepository = locationRepository;
    }

    public List<LocationResponse> getAllLocations(com.qubikore.assetsteward.user.User currentUser) {
        return locationRepository.findByOrganization(currentUser.getOrganization()).stream()
                .map(LocationResponse::new)
                .collect(Collectors.toList());
    }

    public LocationResponse getLocationById(Long id) {
        Location location = locationRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Location not found"));
        return new LocationResponse(location);
    }

    public LocationResponse createLocation(LocationRequest request, com.qubikore.assetsteward.user.User currentUser) {
        Location location = new Location(request.getName(), request.getAddress());
        location.setOrganization(currentUser.getOrganization());

        location = locationRepository.save(location);
        return new LocationResponse(location);
    }

    public LocationResponse updateLocation(Long id, LocationRequest request) {
        Location location = locationRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Location not found"));
        
        location.setName(request.getName());
        location.setAddress(request.getAddress());
        location = locationRepository.save(location);
        return new LocationResponse(location);
    }

    public void deleteLocation(Long id) {
        Location location = locationRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Location not found"));
        locationRepository.delete(location);
    }
}
