package com.qubikore.assetsteward.asset.dto;

import com.qubikore.assetsteward.asset.Asset;
import java.time.LocalDate;

public class AssetResponse {
    private Long id;
    private String assetCode;
    private String name;
    private String serialNumber;
    private LocalDate purchaseDate;
    private LocalDate expireDate;
    private Double purchasePrice;
    private String vendor;
    private Integer quantity;
    private String status;
    private com.qubikore.assetsteward.category.CategoryResponse category;
    private com.qubikore.assetsteward.location.LocationResponse location;
    private com.qubikore.assetsteward.department.DepartmentResponse department;
    private CreatorResponse createdBy;
    private java.time.LocalDateTime createdAt;
    private java.time.LocalDateTime updatedAt;

    public AssetResponse(Asset asset) {
        this.id = asset.getId();
        this.assetCode = asset.getAssetCode();
        this.name = asset.getName();
        this.serialNumber = asset.getSerialNumber();
        this.purchaseDate = asset.getPurchaseDate();
        this.expireDate = asset.getExpireDate();
        this.purchasePrice = asset.getPurchasePrice();
        this.vendor = asset.getVendor();
        this.quantity = asset.getQuantity();
        this.status = asset.getStatus().name();
        this.category = asset.getCategory() != null ? new com.qubikore.assetsteward.category.CategoryResponse(asset.getCategory()) : null;
        this.location = asset.getLocation() != null ? new com.qubikore.assetsteward.location.LocationResponse(asset.getLocation()) : null;
        this.department = asset.getDepartment() != null ? new com.qubikore.assetsteward.department.DepartmentResponse(asset.getDepartment()) : null;
        this.createdBy = asset.getCreatedBy() != null ? new CreatorResponse(asset.getCreatedBy()) : null;
        this.createdAt = asset.getCreatedAt();
        this.updatedAt = asset.getUpdatedAt();
    }

    public static class CreatorResponse {
        private Long id;
        private String firstname;
        private String lastname;
        private String email;
        private String role;
        
        public CreatorResponse(com.qubikore.assetsteward.user.User user) {
            this.id = user.getId();
            this.firstname = user.getFirstname();
            this.lastname = user.getLastname();
            this.email = user.getEmail();
            this.role = user.getRole() != null ? user.getRole().name() : null;
        }

        public Long getId() { return id; }
        public String getFirstname() { return firstname; }
        public String getLastname() { return lastname; }
        public String getEmail() { return email; }
        public String getRole() { return role; }
    }

    public Long getId() { return id; }
    public String getAssetCode() { return assetCode; }
    public String getName() { return name; }
    public String getSerialNumber() { return serialNumber; }
    public LocalDate getPurchaseDate() { return purchaseDate; }
    public LocalDate getExpireDate() { return expireDate; }
    public Double getPurchasePrice() { return purchasePrice; }
    public String getVendor() { return vendor; }
    public Integer getQuantity() { return quantity; }
    public String getStatus() { return status; }
    public com.qubikore.assetsteward.category.CategoryResponse getCategory() { return category; }
    public com.qubikore.assetsteward.location.LocationResponse getLocation() { return location; }
    public com.qubikore.assetsteward.department.DepartmentResponse getDepartment() { return department; }
    public CreatorResponse getCreatedBy() { return createdBy; }
    public java.time.LocalDateTime getCreatedAt() { return createdAt; }
    public java.time.LocalDateTime getUpdatedAt() { return updatedAt; }
}
