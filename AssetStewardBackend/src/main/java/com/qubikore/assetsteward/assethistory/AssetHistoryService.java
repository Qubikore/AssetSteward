package com.qubikore.assetsteward.assethistory;

import com.qubikore.assetsteward.asset.Asset;
import com.qubikore.assetsteward.user.User;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class AssetHistoryService {

    private final AssetHistoryRepository assetHistoryRepository;

    public AssetHistoryService(AssetHistoryRepository assetHistoryRepository) {
        this.assetHistoryRepository = assetHistoryRepository;
    }

    public void logAction(Asset asset, User actionBy, String action, String notes) {
        AssetHistory history = new AssetHistory();
        history.setAsset(asset);
        history.setActionBy(actionBy);
        history.setAction(action);
        history.setTimestamp(LocalDateTime.now());
        history.setNotes(notes);
        assetHistoryRepository.save(history);
    }
}
