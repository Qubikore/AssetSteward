#!/bin/bash
sed -i '' -e '/^}$/d' src/main/java/com/qubikore/assetsteward/asset/AssetController.java
cat << 'INNER_EOF' >> src/main/java/com/qubikore/assetsteward/asset/AssetController.java

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
INNER_EOF
