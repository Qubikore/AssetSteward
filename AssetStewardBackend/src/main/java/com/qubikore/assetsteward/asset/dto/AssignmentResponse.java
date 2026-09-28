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
    private java.util.List<com.qubikore.assetsteward.assethistory.AssetHistoryResponse> history;

    public AssignmentResponse(Assignment assignment) {
        this.id = assignment.getId();
        this.asset = new AssetResponse(assignment.getAsset());
        this.assignedTo = new AssetResponse.CreatorResponse(assignment.getAssignedTo());
        this.assignedBy = new AssetResponse.CreatorResponse(assignment.getAssignedBy());
        this.assignedAt = assignment.getAssignedAt();
        this.returnedAt = assignment.getReturnedAt();
        this.returnReason = assignment.getReturnReason();
    }

    // Getters
    public Long getId() { return id; }
    public AssetResponse getAsset() { return asset; }
    public AssetResponse.CreatorResponse getAssignedTo() { return assignedTo; }
    public AssetResponse.CreatorResponse getAssignedBy() { return assignedBy; }
    public LocalDateTime getAssignedAt() { return assignedAt; }
    public LocalDateTime getReturnedAt() { return returnedAt; }
    public String getReturnReason() { return returnReason; }
    public java.util.List<com.qubikore.assetsteward.assethistory.AssetHistoryResponse> getHistory() { return history; }
    public void setHistory(java.util.List<com.qubikore.assetsteward.assethistory.AssetHistoryResponse> history) { this.history = history; }
}
