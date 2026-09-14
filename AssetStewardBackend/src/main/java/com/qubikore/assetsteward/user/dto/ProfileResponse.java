package com.qubikore.assetsteward.user.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.qubikore.assetsteward.user.User;
import java.time.LocalDate;

public class ProfileResponse {

    private Long id;
    private String firstname;
    private String lastname;
    private String email;
    private String role;
    private String gender;
    private LocalDate dob;
    
    @JsonProperty("profile_picture")
    private String profilePicture;

    public ProfileResponse(User user, String backendUrl) {
        this.id = user.getId();
        this.firstname = user.getFirstname();
        this.lastname = user.getLastname();
        this.email = user.getEmail();
        this.role = user.getRole().name();
        this.gender = user.getGender();
        this.dob = user.getDob();
        
        if (user.getProfilePicture() != null && !user.getProfilePicture().isEmpty()) {
            this.profilePicture = backendUrl + user.getProfilePicture();
        } else {
            this.profilePicture = null;
        }
    }

    // Getters
    public Long getId() { return id; }
    public String getFirstname() { return firstname; }
    public String getLastname() { return lastname; }
    public String getEmail() { return email; }
    public String getRole() { return role; }
    public String getGender() { return gender; }
    public LocalDate getDob() { return dob; }
    public String getProfilePicture() { return profilePicture; }
}
