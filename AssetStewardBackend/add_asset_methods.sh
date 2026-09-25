#!/bin/bash
sed -i '' '/public void deleteAsset/,$d' src/main/java/com/qubikore/assetsteward/asset/AssetService.java
sed -i '' '/public AssetResponse updateAsset/,$d' src/main/java/com/qubikore/assetsteward/asset/AssetService.java

# We need to insert before the last brace.
sed -i '' -e '/^}$/d' src/main/java/com/qubikore/assetsteward/asset/AssetService.java
cat << 'INNER_EOF' >> src/main/java/com/qubikore/assetsteward/asset/AssetService.java

    public AssetResponse updateAsset(Long assetId, AssetRequest request, User currentUser) {
        Asset asset = assetRepository.findById(assetId)
                .orElseThrow(() -> new RuntimeException("Asset not found"));
        
        if (asset.getOrganization() == null || !asset.getOrganization().getId().equals(currentUser.getOrganization().getId())) {
            throw new RuntimeException("Asset does not belong to your organization");
        }

        if (request.getName() != null) asset.setName(request.getName());
        if (request.getSerialNumber() != null) asset.setSerialNumber(request.getSerialNumber());
        if (request.getPurchaseDate() != null) asset.setPurchaseDate(request.getPurchaseDate());
        if (request.getExpireDate() != null) asset.setExpireDate(request.getExpireDate());
        if (request.getPurchasePrice() != null) asset.setPurchasePrice(request.getPurchasePrice());
        if (request.getVendor() != null) asset.setVendor(request.getVendor());
        if (request.getQuantity() != null) asset.setQuantity(request.getQuantity());

        if (request.getCategoryId() != null) {
            Category cat = categoryRepository.findById(request.getCategoryId()).orElse(null);
            asset.setCategory(cat);
        }

        if (request.getLocationId() != null) {
            Location loc = locationRepository.findById(request.getLocationId()).orElse(null);
            asset.setLocation(loc);
        }

        if (request.getDepartmentId() != null) {
            com.qubikore.assetsteward.department.Department dept = departmentRepository.findById(request.getDepartmentId()).orElse(null);
            asset.setDepartment(dept);
        }

        assetRepository.save(asset);
        assetHistoryService.logAction(asset, currentUser, "UPDATED", "Asset details updated.");
        return new AssetResponse(asset);
    }

    public void deleteAsset(Long assetId, User currentUser) {
        Asset asset = assetRepository.findById(assetId)
                .orElseThrow(() -> new RuntimeException("Asset not found"));
        
        if (asset.getOrganization() == null || !asset.getOrganization().getId().equals(currentUser.getOrganization().getId())) {
            throw new RuntimeException("Asset does not belong to your organization");
        }

        assetRepository.delete(asset);
    }
}
INNER_EOF
