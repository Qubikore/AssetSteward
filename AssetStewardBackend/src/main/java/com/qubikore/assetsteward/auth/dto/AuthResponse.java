package com.qubikore.assetsteward.auth.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

public class AuthResponse {

    @JsonProperty("access_token")
    private String accessToken;

    @JsonProperty("token_type")
    private String tokenType;

    @JsonProperty("expires_at")
    private double expiresAt;

    public AuthResponse() {}

    public AuthResponse(String accessToken, String tokenType, double expiresAt) {
        this.accessToken = accessToken;
        this.tokenType = tokenType;
        this.expiresAt = expiresAt;
    }

    public String getAccessToken() { return accessToken; }
    public void setAccessToken(String accessToken) { this.accessToken = accessToken; }
    
    public String getTokenType() { return tokenType; }
    public void setTokenType(String tokenType) { this.tokenType = tokenType; }
    
    public double getExpiresAt() { return expiresAt; }
    public void setExpiresAt(double expiresAt) { this.expiresAt = expiresAt; }
}
