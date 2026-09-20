package com.qubikore.assetsteward.dashboard;

public class DashboardMetrics {
    private long totalAssets;
    private long availableAssets;
    private long assignedAssets;
    private long maintenanceAssets;
    private double totalAssetValue;

    // Getters and Setters
    public long getTotalAssets() { return totalAssets; }
    public void setTotalAssets(long totalAssets) { this.totalAssets = totalAssets; }
    public long getAvailableAssets() { return availableAssets; }
    public void setAvailableAssets(long availableAssets) { this.availableAssets = availableAssets; }
    public long getAssignedAssets() { return assignedAssets; }
    public void setAssignedAssets(long assignedAssets) { this.assignedAssets = assignedAssets; }
    public long getMaintenanceAssets() { return maintenanceAssets; }
    public void setMaintenanceAssets(long maintenanceAssets) { this.maintenanceAssets = maintenanceAssets; }
    public double getTotalAssetValue() { return totalAssetValue; }
    public void setTotalAssetValue(double totalAssetValue) { this.totalAssetValue = totalAssetValue; }
}
