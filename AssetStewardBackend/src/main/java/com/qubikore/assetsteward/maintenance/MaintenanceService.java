package com.qubikore.assetsteward.maintenance;

import com.qubikore.assetsteward.asset.Asset;
import com.qubikore.assetsteward.asset.AssetRepository;
import com.qubikore.assetsteward.asset.AssetStatus;
import com.qubikore.assetsteward.assethistory.AssetHistoryService;
import com.qubikore.assetsteward.user.User;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class MaintenanceService {

    private final MaintenanceRepository maintenanceRepository;
    private final AssetRepository assetRepository;
    private final AssetHistoryService assetHistoryService;

    public MaintenanceService(MaintenanceRepository maintenanceRepository, AssetRepository assetRepository, AssetHistoryService assetHistoryService) {
        this.maintenanceRepository = maintenanceRepository;
        this.assetRepository = assetRepository;
        this.assetHistoryService = assetHistoryService;
    }

    public MaintenanceResponse startMaintenance(MaintenanceRequest request, User currentUser) {
        Asset asset = assetRepository.findById(request.getAssetId())
                .orElseThrow(() -> new RuntimeException("Asset not found"));

        Maintenance m = new Maintenance();
        m.setAsset(asset);
        m.setDescription(request.getDescription());
        m.setCost(request.getCost());
        m.setProvider(request.getProvider());
        m.setStartDate(request.getStartDate() != null ? request.getStartDate() : LocalDate.now());
        m.setStatus("IN_PROGRESS");

        maintenanceRepository.save(m);

        asset.setStatus(AssetStatus.MAINTENANCE);
        assetRepository.save(asset);

        assetHistoryService.logAction(asset, currentUser, "MAINTENANCE_STARTED", "Sent to maintenance: " + request.getDescription());

        return new MaintenanceResponse(m);
    }

    public MaintenanceResponse completeMaintenance(Long maintenanceId, User currentUser) {
        Maintenance m = maintenanceRepository.findById(maintenanceId)
                .orElseThrow(() -> new RuntimeException("Maintenance record not found"));

        if (!m.getStatus().equals("IN_PROGRESS")) {
            throw new RuntimeException("Maintenance is already completed or not in progress.");
        }

        m.setStatus("COMPLETED");
        m.setEndDate(LocalDate.now());
        maintenanceRepository.save(m);

        Asset asset = m.getAsset();
        asset.setStatus(AssetStatus.AVAILABLE);
        assetRepository.save(asset);

        assetHistoryService.logAction(asset, currentUser, "MAINTENANCE_COMPLETED", "Returned from maintenance.");

        return new MaintenanceResponse(m);
    }

    public List<MaintenanceResponse> getAllMaintenance() {
        return maintenanceRepository.findAll().stream()
                .map(MaintenanceResponse::new)
                .collect(Collectors.toList());
    }
}
