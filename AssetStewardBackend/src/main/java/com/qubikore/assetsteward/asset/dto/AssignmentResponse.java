package com.qubikore.assetsteward.asset.dto;

import com.qubikore.assetsteward.asset.Assignment;
import java.time.LocalDateTime;

public class AssignmentResponse {
    private Long id;
    private Long assetId;
    private String assetName;
    private String assetCode;
    
    private Long assignedToUserId;
    private String assignedToEmail;
    
    private Long assignedByUserId;
    private String assignedByEmail;
    
    private LocalDateTime assignedAt;
    private LocalDateTime returnedAt;

    public AssignmentResponse(Assignment assignment) {
        this.id = assignment.getId();
        this.assetId = assignment.getAsset().getId();
        this.assetName = assignment.getAsset().getName();
        this.assetCode = assignment.getAsset().getAssetCode();
        
        this.assignedToUserId = assignment.getAssignedTo().getId();
        this.assignedToEmail = assignment.getAssignedTo().getEmail();
        
        this.assignedByUserId = assignment.getAssignedBy().getId();
        this.assignedByEmail = assignment.getAssignedBy().getEmail();
        
        this.assignedAt = assignment.getAssignedAt();
        this.returnedAt = assignment.getReturnedAt();
    }

    // Getters
    public Long getId() { return id; }
    public Long getAssetId() { return assetId; }
    public String getAssetName() { return assetName; }
    public String getAssetCode() { return assetCode; }
    public Long getAssignedToUserId() { return assignedToUserId; }
    public String getAssignedToEmail() { return assignedToEmail; }
    public Long getAssignedByUserId() { return assignedByUserId; }
    public String getAssignedByEmail() { return assignedByEmail; }
    public LocalDateTime getAssignedAt() { return assignedAt; }
    public LocalDateTime getReturnedAt() { return returnedAt; }
}
