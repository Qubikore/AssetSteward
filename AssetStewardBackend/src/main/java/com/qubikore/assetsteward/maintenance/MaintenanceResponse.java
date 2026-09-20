package com.qubikore.assetsteward.maintenance;

import java.time.LocalDate;

public class MaintenanceResponse {
    private Long id;
    private Long assetId;
    private String assetName;
    private String description;
    private Double cost;
    private String provider;
    private LocalDate startDate;
    private LocalDate endDate;
    private String status;

    public MaintenanceResponse(Maintenance m) {
        this.id = m.getId();
        this.assetId = m.getAsset().getId();
        this.assetName = m.getAsset().getName();
        this.description = m.getDescription();
        this.cost = m.getCost();
        this.provider = m.getProvider();
        this.startDate = m.getStartDate();
        this.endDate = m.getEndDate();
        this.status = m.getStatus();
    }

    public Long getId() { return id; }
    public Long getAssetId() { return assetId; }
    public String getAssetName() { return assetName; }
    public String getDescription() { return description; }
    public Double getCost() { return cost; }
    public String getProvider() { return provider; }
    public LocalDate getStartDate() { return startDate; }
    public LocalDate getEndDate() { return endDate; }
    public String getStatus() { return status; }
}
