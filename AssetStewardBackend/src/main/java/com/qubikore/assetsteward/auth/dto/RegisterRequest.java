package com.qubikore.assetsteward.auth.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

public class RegisterRequest {

    private String firstname;
    private String lastname;
    private String email;
    private String password;

    @JsonProperty("remember_me")
    private boolean rememberMe;

    public RegisterRequest() {}

    public RegisterRequest(String firstname, String lastname, String email, String password, boolean rememberMe) {
        this.firstname = firstname;
        this.lastname = lastname;
        this.email = email;
        this.password = password;
        this.rememberMe = rememberMe;
    }

    public String getFirstname() { return firstname; }
    public void setFirstname(String firstname) { this.firstname = firstname; }
    public String getLastname() { return lastname; }
    public void setLastname(String lastname) { this.lastname = lastname; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public boolean isRememberMe() { return rememberMe; }
    public void setRememberMe(boolean rememberMe) { this.rememberMe = rememberMe; }
}
