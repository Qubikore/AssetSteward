package com.qubikore.assetsteward.asset;

import com.qubikore.assetsteward.asset.dto.AssetAssignmentRequest;
import com.qubikore.assetsteward.asset.dto.AssetRequest;
import com.qubikore.assetsteward.asset.dto.AssetResponse;
import com.qubikore.assetsteward.common.dto.ApiResponse;
import com.qubikore.assetsteward.user.User;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/assets")
@SecurityRequirement(name = "Bearer Authentication")
public class AssetController {

    private final AssetService assetService;

    public AssetController(AssetService assetService) {
        this.assetService = assetService;
    }

    @PostMapping
    public ResponseEntity<ApiResponse<AssetResponse>> createAsset(
            @RequestBody AssetRequest request,
            @AuthenticationPrincipal User currentUser) {
        AssetResponse response = assetService.createAsset(request, currentUser);
        return ResponseEntity.ok(ApiResponse.success("Asset created successfully", response));
    }

    @PutMapping("/{assetId}/approve")
    public ResponseEntity<ApiResponse<AssetResponse>> approveAsset(
            @PathVariable Long assetId,
            @AuthenticationPrincipal User currentUser) {
        AssetResponse response = assetService.approveAsset(assetId, currentUser);
        return ResponseEntity.ok(ApiResponse.success("Asset approved successfully", response));
    }

    @PostMapping("/assign")
    public ResponseEntity<ApiResponse<String>> assignAsset(
            @RequestBody AssetAssignmentRequest request,
            @AuthenticationPrincipal User currentUser) {
        assetService.assignAsset(request, currentUser);
        return ResponseEntity.ok(ApiResponse.success("Asset assigned successfully", null));
    }

    @GetMapping
    public ResponseEntity<ApiResponse<List<AssetResponse>>> getAllAssets() {
        return ResponseEntity.ok(ApiResponse.success("Assets retrieved successfully", assetService.getAllAssets()));
    }
}
