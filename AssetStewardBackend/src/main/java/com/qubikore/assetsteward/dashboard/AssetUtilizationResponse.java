package com.qubikore.assetsteward.dashboard;

public class AssetUtilizationResponse {
    private Long assetId;
    private String assetName;
    private String assetCode;
    private String status;
    private long assignmentCount;
    private long maintenanceCount;

    public AssetUtilizationResponse(Long assetId, String assetName, String assetCode, String status, long assignmentCount, long maintenanceCount) {
        this.assetId = assetId;
        this.assetName = assetName;
        this.assetCode = assetCode;
        this.status = status;
        this.assignmentCount = assignmentCount;
        this.maintenanceCount = maintenanceCount;
    }

    public Long getAssetId() { return assetId; }
    public String getAssetName() { return assetName; }
    public String getAssetCode() { return assetCode; }
    public String getStatus() { return status; }
    public long getAssignmentCount() { return assignmentCount; }
    public long getMaintenanceCount() { return maintenanceCount; }
}
