package com.qubikore.assetsteward.asset.dto;

public class AssetReturnRequest {
    private Long assetId;
    private String reason;

    public Long getAssetId() { return assetId; }
    public void setAssetId(Long assetId) { this.assetId = assetId; }
    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }
}
