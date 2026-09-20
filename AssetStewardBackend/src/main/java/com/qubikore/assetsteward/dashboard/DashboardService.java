package com.qubikore.assetsteward.dashboard;

import com.qubikore.assetsteward.asset.Asset;
import com.qubikore.assetsteward.asset.AssetRepository;
import com.qubikore.assetsteward.asset.AssetStatus;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DashboardService {
    private final AssetRepository assetRepository;
    private final com.qubikore.assetsteward.asset.AssignmentRepository assignmentRepository;
    private final com.qubikore.assetsteward.maintenance.MaintenanceRepository maintenanceRepository;

    public DashboardService(AssetRepository assetRepository, com.qubikore.assetsteward.asset.AssignmentRepository assignmentRepository, com.qubikore.assetsteward.maintenance.MaintenanceRepository maintenanceRepository) {
        this.assetRepository = assetRepository;
        this.assignmentRepository = assignmentRepository;
        this.maintenanceRepository = maintenanceRepository;
    }

    public DashboardMetrics getMetrics() {
        List<Asset> assets = assetRepository.findAll();
        
        DashboardMetrics metrics = new DashboardMetrics();
        metrics.setTotalAssets(assets.size());
        
        long available = 0;
        long assigned = 0;
        long maintenance = 0;
        double totalValue = 0.0;
        
        for (Asset asset : assets) {
            if (asset.getStatus() == AssetStatus.AVAILABLE) available++;
            else if (asset.getStatus() == AssetStatus.ASSIGNED) assigned++;
            else if (asset.getStatus() == AssetStatus.MAINTENANCE) maintenance++;
            
            if (asset.getPurchasePrice() != null) {
                totalValue += asset.getPurchasePrice();
            }
        }
        
        metrics.setAvailableAssets(available);
        metrics.setAssignedAssets(assigned);
        metrics.setMaintenanceAssets(maintenance);
        metrics.setTotalAssetValue(totalValue);
        
        return metrics;
    }

    public List<AssetUtilizationResponse> getAssetUtilization() {
        List<Asset> assets = assetRepository.findAll();
        List<AssetUtilizationResponse> utilizationList = new java.util.ArrayList<>();
        
        // Fetch all assignments and maintenance once, or query per asset.
        // For simplicity, query per asset (could be optimized).
        for (Asset asset : assets) {
            long assignCount = assignmentRepository.findAll().stream()
                .filter(a -> a.getAsset().getId().equals(asset.getId())).count();
                
            long mainCount = maintenanceRepository.findByAssetId(asset.getId()).size();
            
            utilizationList.add(new AssetUtilizationResponse(
                asset.getId(),
                asset.getName(),
                asset.getAssetCode(),
                asset.getStatus().name(),
                assignCount,
                mainCount
            ));
        }
        
        // Sort by least utilized (e.g., status is AVAILABLE and assignCount is 0)
        utilizationList.sort((a, b) -> Long.compare(a.getAssignmentCount(), b.getAssignmentCount()));
        
        return utilizationList;
    }
}
