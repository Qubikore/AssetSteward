package com.qubikore.assetsteward.asset.dto;

public class AssetAssignmentRequest {
    private Long assetId;
    private Long userId;
    private Long locationId;

    public Long getAssetId() { return assetId; }
    public void setAssetId(Long assetId) { this.assetId = assetId; }
    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }
    public Long getLocationId() { return locationId; }
    public void setLocationId(Long locationId) { this.locationId = locationId; }
}
