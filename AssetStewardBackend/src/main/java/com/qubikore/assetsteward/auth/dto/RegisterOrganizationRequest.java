package com.qubikore.assetsteward.auth.dto;

public class RegisterOrganizationRequest {

    private String organizationName;
    private String organizationPhone;
    private String organizationEmail;
    private String organizationLocation;
    
    private String firstname;
    private String lastname;
    private String email;
    private String password;

    public RegisterOrganizationRequest() {}

    public String getOrganizationName() { return organizationName; }
    public void setOrganizationName(String organizationName) { this.organizationName = organizationName; }

    public String getOrganizationPhone() { return organizationPhone; }
    public void setOrganizationPhone(String organizationPhone) { this.organizationPhone = organizationPhone; }

    public String getOrganizationEmail() { return organizationEmail; }
    public void setOrganizationEmail(String organizationEmail) { this.organizationEmail = organizationEmail; }

    public String getOrganizationLocation() { return organizationLocation; }
    public void setOrganizationLocation(String organizationLocation) { this.organizationLocation = organizationLocation; }

    public String getFirstname() { return firstname; }
    public void setFirstname(String firstname) { this.firstname = firstname; }

    public String getLastname() { return lastname; }
    public void setLastname(String lastname) { this.lastname = lastname; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}
