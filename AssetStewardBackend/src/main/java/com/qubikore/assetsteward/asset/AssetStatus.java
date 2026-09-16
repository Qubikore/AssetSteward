package com.qubikore.assetsteward.asset;

public enum AssetStatus {
    PENDING_APPROVAL, // When created by a regular USER
    AVAILABLE,        // Approved and ready to be assigned
    ASSIGNED,         // Assigned to a user
    MAINTENANCE,      // Under maintenance
    RETURNED,         // Returned but maybe needs check
    RETIRED           // End of life
}
