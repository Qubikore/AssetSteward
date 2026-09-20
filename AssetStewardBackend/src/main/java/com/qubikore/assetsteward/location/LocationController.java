package com.qubikore.assetsteward.location;

import com.qubikore.assetsteward.common.dto.ApiResponse;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/locations")
@SecurityRequirement(name = "Bearer Authentication")
public class LocationController {

    private final LocationService locationService;

    public LocationController(LocationService locationService) {
        this.locationService = locationService;
    }

    @GetMapping
    public ResponseEntity<ApiResponse<List<LocationResponse>>> getAllLocations() {
        return ResponseEntity.ok(ApiResponse.success("Locations fetched successfully", locationService.getAllLocations()));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<LocationResponse>> getLocationById(@PathVariable Long id) {
        return ResponseEntity.ok(ApiResponse.success("Location fetched successfully", locationService.getLocationById(id)));
    }

    @PostMapping
    public ResponseEntity<ApiResponse<LocationResponse>> createLocation(@RequestBody LocationRequest request) {
        return ResponseEntity.ok(ApiResponse.success("Location created successfully", locationService.createLocation(request)));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ApiResponse<LocationResponse>> updateLocation(@PathVariable Long id, @RequestBody LocationRequest request) {
        return ResponseEntity.ok(ApiResponse.success("Location updated successfully", locationService.updateLocation(id, request)));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteLocation(@PathVariable Long id) {
        locationService.deleteLocation(id);
        return ResponseEntity.ok(ApiResponse.success("Location deleted successfully", null));
    }
}
