package com.qubikore.assetsteward.maintenance;

import com.qubikore.assetsteward.common.dto.ApiResponse;
import com.qubikore.assetsteward.user.User;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/maintenance")
@SecurityRequirement(name = "Bearer Authentication")
public class MaintenanceController {

    private final MaintenanceService maintenanceService;

    public MaintenanceController(MaintenanceService maintenanceService) {
        this.maintenanceService = maintenanceService;
    }

    @Operation(summary = "Start asset maintenance", description = "Moves an asset into IN_PROGRESS maintenance status and logs the history.")
    @PostMapping("/start")
    public ResponseEntity<ApiResponse<MaintenanceResponse>> startMaintenance(
            @RequestBody MaintenanceRequest request,
            @AuthenticationPrincipal User currentUser) {
        return ResponseEntity.ok(ApiResponse.success("Maintenance started", maintenanceService.startMaintenance(request, currentUser)));
    }

    @Operation(summary = "Complete asset maintenance", description = "Marks a maintenance record as COMPLETED and returns the asset to AVAILABLE status.")
    @PutMapping("/{id}/complete")
    public ResponseEntity<ApiResponse<MaintenanceResponse>> completeMaintenance(
            @PathVariable Long id,
            @AuthenticationPrincipal User currentUser) {
        return ResponseEntity.ok(ApiResponse.success("Maintenance completed", maintenanceService.completeMaintenance(id, currentUser)));
    }

    @Operation(summary = "Get all maintenance records", description = "Fetches a list of all maintenance events (active and completed).")
    @GetMapping
    public ResponseEntity<ApiResponse<List<MaintenanceResponse>>> getAllMaintenance(@AuthenticationPrincipal User currentUser) {
        return ResponseEntity.ok(ApiResponse.success("Fetched all maintenance records", maintenanceService.getAllMaintenance(currentUser)));
    }
}
