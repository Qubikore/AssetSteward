package com.qubikore.assetsteward.user;

import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "Represents the user's role in the system for RBAC.")
public enum Role {
    SUPER_ADMIN,
    HR,
    USER
}
