package com.qubikore.assetsteward.user.dto;

import com.qubikore.assetsteward.user.Organization;

public class OrganizationResponse {
    private Long id;
    private String name;
    private String phone;
    private String email;
    private String location;

    public OrganizationResponse(Organization org) {
        if (org != null) {
            this.id = org.getId();
            this.name = org.getName();
            this.phone = org.getPhone();
            this.email = org.getEmail();
            this.location = org.getLocation();
        }
    }

    public Long getId() { return id; }
    public String getName() { return name; }
    public String getPhone() { return phone; }
    public String getEmail() { return email; }
    public String getLocation() { return location; }
}
