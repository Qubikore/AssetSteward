package com.qubikore.assetsteward.asset;

import com.qubikore.assetsteward.asset.dto.AssetAssignmentRequest;
import com.qubikore.assetsteward.asset.dto.AssetRequest;
import com.qubikore.assetsteward.asset.dto.AssetResponse;
import com.qubikore.assetsteward.common.dto.ApiResponse;
import com.qubikore.assetsteward.user.User;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/assets")
@SecurityRequirement(name = "Bearer Authentication")
public class AssetController {

    private final AssetService assetService;
    private final com.qubikore.assetsteward.asset.QRCodeService qrCodeService;

    public AssetController(AssetService assetService, com.qubikore.assetsteward.asset.QRCodeService qrCodeService) {
        this.assetService = assetService;
        this.qrCodeService = qrCodeService;
    }

    @Operation(summary = "Create a new asset", description = "Registers a new asset into the system with its purchase details, category, location, and department.")
    @PostMapping
    public ResponseEntity<ApiResponse<AssetResponse>> createAsset(
            @RequestBody AssetRequest request,
            @AuthenticationPrincipal User currentUser) {
        AssetResponse response = assetService.createAsset(request, currentUser);
        return ResponseEntity.ok(ApiResponse.success("Asset created successfully", response));
    }

    @Operation(summary = "Approve an asset", description = "Approves a pending asset. Only HR and Super Admin can perform this action.")
    @PutMapping("/{assetId}/approve")
    public ResponseEntity<ApiResponse<AssetResponse>> approveAsset(
            @PathVariable Long assetId,
            @AuthenticationPrincipal User currentUser) {
        AssetResponse response = assetService.approveAsset(assetId, currentUser);
        return ResponseEntity.ok(ApiResponse.success("Asset approved successfully", response));
    }

    @Operation(summary = "Assign an asset", description = "Assigns an available asset to a specific user.")
    @PostMapping("/assign")
    public ResponseEntity<ApiResponse<String>> assignAsset(
            @RequestBody AssetAssignmentRequest request,
            @AuthenticationPrincipal User currentUser) {
        assetService.assignAsset(request, currentUser);
        return ResponseEntity.ok(ApiResponse.success("Asset assigned successfully", null));
    }

    @Operation(summary = "Transfer an asset", description = "Transfers an already assigned asset from the current user to a new user.")
    @PostMapping("/transfer")
    public ResponseEntity<ApiResponse<String>> transferAsset(
            @RequestBody AssetAssignmentRequest request,
            @AuthenticationPrincipal User currentUser) {
        assetService.transferAsset(request, currentUser);
        return ResponseEntity.ok(ApiResponse.success("Asset transferred successfully", null));
    }

    @Operation(summary = "Get all assets", description = "Retrieves a list of all assets with optional filtering.")
    @GetMapping
    public ResponseEntity<ApiResponse<List<AssetResponse>>> getAllAssets(
            @RequestParam(required = false) Long categoryId,
            @RequestParam(required = false) Long locationId,
            @RequestParam(required = false) Long departmentId,
            @RequestParam(required = false) String status,
            @RequestParam(required = false) String search, @AuthenticationPrincipal User currentUser) {
        return ResponseEntity.ok(ApiResponse.success("Assets retrieved successfully", assetService.getAllAssets(categoryId, locationId, departmentId, status, search, currentUser)));
    }

    @Operation(summary = "Get asset assignments", description = "Retrieves a list of asset assignments. Can be filtered by status.")
    @GetMapping("/assignments")
    public ResponseEntity<ApiResponse<List<com.qubikore.assetsteward.asset.dto.AssignmentResponse>>> getAllAssignments(
            @io.swagger.v3.oas.annotations.Parameter(description = "Filter by status. Allowed values: 'active' (currently assigned), 'returned' (past assignments), or leave empty for all.") 
            @RequestParam(required = false) String status,
            @AuthenticationPrincipal User currentUser) {
        if (currentUser.getRole() != com.qubikore.assetsteward.user.Role.SUPER_ADMIN && currentUser.getRole() != com.qubikore.assetsteward.user.Role.HR) {
            throw new RuntimeException("Only HR or Admin can view all assignments.");
        }
        return ResponseEntity.ok(ApiResponse.success("Assignments retrieved successfully", assetService.getAllAssignments(status, currentUser)));
    }

    @Operation(summary = "Generate QR Code", description = "Generates a PNG QR code image for a specific asset based on its assetCode.")
    @GetMapping(value = "/{assetId}/qrcode", produces = org.springframework.http.MediaType.IMAGE_PNG_VALUE)
    public ResponseEntity<byte[]> getQRCode(@PathVariable Long assetId, @AuthenticationPrincipal User currentUser) {
        try {
            // We just need the assetCode. Let's fetch the asset from the service.
            // Since getAllAssets isn't ideal, let's create a getAssetById in AssetService or fetch it here.
            // For now, let's just generate it using the ID to avoid modifying AssetService again.
            // But actually we need the AssetCode. Let's assume assetCode = "AST-" + assetId or something.
            // Wait, we can iterate getAllAssets() or we can add getAssetById to AssetService.
            // I'll just use a placeholder text if I don't fetch it, but let's fetch it.
            AssetResponse asset = assetService.getAllAssets(null, null, null, null, null, currentUser).stream()
                .filter(a -> a.getId().equals(assetId)).findFirst().orElseThrow(() -> new RuntimeException("Asset not found"));
                
            byte[] image = qrCodeService.generateQRCodeImage(asset.getAssetCode(), 250, 250);
            return ResponseEntity.ok().body(image);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }

    @Operation(summary = "Get asset labels", description = "Retrieves all assets with their QR codes in base64 format and basic info (price, dates) for printing labels.")
    @GetMapping("/labels")
    public ResponseEntity<ApiResponse<List<com.qubikore.assetsteward.asset.dto.AssetLabelResponse>>> getAssetLabels(
            @AuthenticationPrincipal User currentUser) {
        List<com.qubikore.assetsteward.asset.dto.AssetLabelResponse> labels = assetService.getAssetLabels(currentUser, qrCodeService);
        return ResponseEntity.ok(ApiResponse.success("Asset labels retrieved successfully", labels));
    }

    @Operation(summary = "Update an asset", description = "Updates an existing asset's details.")
    @PutMapping("/{assetId}")
    public ResponseEntity<ApiResponse<AssetResponse>> updateAsset(
            @PathVariable Long assetId,
            @RequestBody AssetRequest request,
            @AuthenticationPrincipal User currentUser) {
        AssetResponse response = assetService.updateAsset(assetId, request, currentUser);
        return ResponseEntity.ok(ApiResponse.success("Asset updated successfully", response));
    }

    @Operation(summary = "Delete an asset", description = "Deletes an asset from the system.")
    @DeleteMapping("/{assetId}")
    public ResponseEntity<ApiResponse<Void>> deleteAsset(
            @PathVariable Long assetId,
            @AuthenticationPrincipal User currentUser) {
        assetService.deleteAsset(assetId, currentUser);
        return ResponseEntity.ok(ApiResponse.success("Asset deleted successfully", null));
    }
}
