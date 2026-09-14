package com.qubikore.assetsteward.auth.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

public class AuthRequest {

    private String email;
    private String password;

    @JsonProperty("remember_me")
    private boolean rememberMe;

    public AuthRequest() {}

    public AuthRequest(String email, String password, boolean rememberMe) {
        this.email = email;
        this.password = password;
        this.rememberMe = rememberMe;
    }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public boolean isRememberMe() { return rememberMe; }
    public void setRememberMe(boolean rememberMe) { this.rememberMe = rememberMe; }
}
