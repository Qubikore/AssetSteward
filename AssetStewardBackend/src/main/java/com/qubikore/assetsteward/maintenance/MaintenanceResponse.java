package com.qubikore.assetsteward.maintenance;

import java.time.LocalDate;

public class MaintenanceResponse {
    private Long id;
    private com.qubikore.assetsteward.asset.dto.AssetResponse asset;
    private String description;
    private Double cost;
    private String provider;
    private LocalDate startDate;
    private LocalDate endDate;
    private String status;
    private com.qubikore.assetsteward.asset.dto.AssetResponse.CreatorResponse startedBy;
    private com.qubikore.assetsteward.asset.dto.AssetResponse.CreatorResponse endedBy;

    public MaintenanceResponse(Maintenance m) {
        this.id = m.getId();
        this.asset = new com.qubikore.assetsteward.asset.dto.AssetResponse(m.getAsset());
        this.description = m.getDescription();
        this.cost = m.getCost();
        this.provider = m.getProvider();
        this.startDate = m.getStartDate();
        this.endDate = m.getEndDate();
        this.status = m.getStatus();
        this.startedBy = m.getStartedBy() != null ? new com.qubikore.assetsteward.asset.dto.AssetResponse.CreatorResponse(m.getStartedBy()) : null;
        this.endedBy = m.getEndedBy() != null ? new com.qubikore.assetsteward.asset.dto.AssetResponse.CreatorResponse(m.getEndedBy()) : null;
    }

    public Long getId() { return id; }
    public com.qubikore.assetsteward.asset.dto.AssetResponse getAsset() { return asset; }
    public String getDescription() { return description; }
    public Double getCost() { return cost; }
    public String getProvider() { return provider; }
    public LocalDate getStartDate() { return startDate; }
    public LocalDate getEndDate() { return endDate; }
    public String getStatus() { return status; }
    public com.qubikore.assetsteward.asset.dto.AssetResponse.CreatorResponse getStartedBy() { return startedBy; }
    public com.qubikore.assetsteward.asset.dto.AssetResponse.CreatorResponse getEndedBy() { return endedBy; }
}
