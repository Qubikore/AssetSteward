package com.qubikore.assetsteward.assethistory;

import java.time.LocalDateTime;

public class AssetHistoryResponse {
    private Long id;
    private String action;
    private LocalDateTime timestamp;
    private String notes;
    private com.qubikore.assetsteward.asset.dto.AssetResponse.CreatorResponse actionBy;

    public AssetHistoryResponse(AssetHistory history) {
        this.id = history.getId();
        this.action = history.getAction();
        this.timestamp = history.getTimestamp();
        this.notes = history.getNotes();
        this.actionBy = history.getActionBy() != null ? new com.qubikore.assetsteward.asset.dto.AssetResponse.CreatorResponse(history.getActionBy()) : null;
    }

    public Long getId() { return id; }
    public String getAction() { return action; }
    public LocalDateTime getTimestamp() { return timestamp; }
    public String getNotes() { return notes; }
    public com.qubikore.assetsteward.asset.dto.AssetResponse.CreatorResponse getActionBy() { return actionBy; }
}
