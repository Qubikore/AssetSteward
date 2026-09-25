package com.qubikore.assetsteward.asset.dto;

import com.qubikore.assetsteward.asset.Asset;
import java.time.LocalDate;

public class AssetLabelResponse {
    private Long id;
    private String name;
    private String assetCode;
    private Double purchasePrice;
    private LocalDate purchaseDate;
    private LocalDate expireDate;
    private String qrCodeBase64;

    public AssetLabelResponse(Asset asset, String qrCodeBase64) {
        this.id = asset.getId();
        this.name = asset.getName();
        this.assetCode = asset.getAssetCode();
        this.purchasePrice = asset.getPurchasePrice();
        this.purchaseDate = asset.getPurchaseDate();
        this.expireDate = asset.getExpireDate();
        this.qrCodeBase64 = qrCodeBase64;
    }

    public Long getId() { return id; }
    public String getName() { return name; }
    public String getAssetCode() { return assetCode; }
    public Double getPurchasePrice() { return purchasePrice; }
    public LocalDate getPurchaseDate() { return purchaseDate; }
    public LocalDate getExpireDate() { return expireDate; }
    public String getQrCodeBase64() { return qrCodeBase64; }
}
