package com.qubikore.assetsteward.user.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import org.springframework.web.multipart.MultipartFile;
import java.time.LocalDate;

public class ProfileUpdateRequest {

    private String firstname;
    private String lastname;
    private String gender;
    private LocalDate dob;
    
    private MultipartFile profile_picture;

    public ProfileUpdateRequest() {}

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public LocalDate getDob() {
        return dob;
    }

    public void setDob(LocalDate dob) {
        this.dob = dob;
    }

    public MultipartFile getProfile_picture() {
        return profile_picture;
    }

    public void setProfile_picture(MultipartFile profile_picture) {
        this.profile_picture = profile_picture;
    }
}
