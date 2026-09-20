package com.qubikore.assetsteward.dashboard;

import com.qubikore.assetsteward.common.dto.ApiResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/dashboard")
@SecurityRequirement(name = "Bearer Authentication")
public class DashboardController {

    private final DashboardService dashboardService;

    public DashboardController(DashboardService dashboardService) {
        this.dashboardService = dashboardService;
    }

    @Operation(summary = "Get Dashboard Metrics", description = "Fetches summarized metrics of all assets.")
    @GetMapping("/metrics")
    public ResponseEntity<ApiResponse<DashboardMetrics>> getMetrics() {
        return ResponseEntity.ok(ApiResponse.success("Dashboard metrics fetched successfully", dashboardService.getMetrics()));
    }

    @Operation(summary = "Get Asset Utilization", description = "Fetches an analytics report identifying underutilized assets based on assignment history.")
    @GetMapping("/utilization")
    public ResponseEntity<ApiResponse<java.util.List<AssetUtilizationResponse>>> getUtilization() {
        return ResponseEntity.ok(ApiResponse.success("Utilization analytics fetched successfully", dashboardService.getAssetUtilization()));
    }
}
