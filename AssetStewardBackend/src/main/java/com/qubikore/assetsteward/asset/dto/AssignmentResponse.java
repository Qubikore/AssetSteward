package com.qubikore.assetsteward.asset.dto;

import com.qubikore.assetsteward.asset.Assignment;
import java.time.LocalDateTime;

public class AssignmentResponse {
    private Long id;
    private AssetResponse asset;
    private AssetResponse.CreatorResponse assignedTo;
    private AssetResponse.CreatorResponse assignedBy;
    private LocalDateTime assignedAt;
    private LocalDateTime returnedAt;
    private String returnReason;

    public AssignmentResponse() {}

    public AssignmentResponse(Assignment assignment) {
        this.id = assignment.getId();
        this.asset = new AssetResponse(assignment.getAsset());
        this.assignedTo = new AssetResponse.CreatorResponse(assignment.getAssignedTo());
        this.assignedBy = new AssetResponse.CreatorResponse(assignment.getAssignedBy());
        this.assignedAt = assignment.getAssignedAt();
        this.returnedAt = assignment.getReturnedAt();
        this.returnReason = assignment.getReturnReason();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public AssetResponse getAsset() { return asset; }
    public void setAsset(AssetResponse asset) { this.asset = asset; }
    public AssetResponse.CreatorResponse getAssignedTo() { return assignedTo; }
    public void setAssignedTo(AssetResponse.CreatorResponse assignedTo) { this.assignedTo = assignedTo; }
    public AssetResponse.CreatorResponse getAssignedBy() { return assignedBy; }
    public void setAssignedBy(AssetResponse.CreatorResponse assignedBy) { this.assignedBy = assignedBy; }
    public LocalDateTime getAssignedAt() { return assignedAt; }
    public void setAssignedAt(LocalDateTime assignedAt) { this.assignedAt = assignedAt; }
    public LocalDateTime getReturnedAt() { return returnedAt; }
    public void setReturnedAt(LocalDateTime returnedAt) { this.returnedAt = returnedAt; }
    public String getReturnReason() { return returnReason; }
    public void setReturnReason(String returnReason) { this.returnReason = returnReason; }
}
