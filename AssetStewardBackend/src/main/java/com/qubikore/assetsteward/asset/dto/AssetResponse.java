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
    private String categoryName;
    private String locationName;
    private String departmentName;

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
        this.categoryName = asset.getCategory() != null ? asset.getCategory().getName() : null;
        this.locationName = asset.getLocation() != null ? asset.getLocation().getName() : null;
        this.departmentName = asset.getDepartment() != null ? asset.getDepartment().getName() : null;
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
    public String getCategoryName() { return categoryName; }
    public String getLocationName() { return locationName; }
    public String getDepartmentName() { return departmentName; }
}
