package com.qubikore.assetsteward.user;

import com.qubikore.assetsteward.common.dto.ApiResponse;
import com.qubikore.assetsteward.user.dto.ProfileResponse;
import com.qubikore.assetsteward.user.dto.ProfileUpdateRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/profile")
public class ProfileController {

    private final UserService userService;

    public ProfileController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping
    public ResponseEntity<ApiResponse<ProfileResponse>> getProfile(Authentication authentication) {
        // authentication.getName() returns the email of the logged-in user (from JwtService)
        ProfileResponse profile = userService.getUserProfile(authentication.getName());
        return ResponseEntity.ok(ApiResponse.success("Profile fetched successfully", profile));
    }

    @PutMapping
    public ResponseEntity<ApiResponse<ProfileResponse>> updateProfile(
            Authentication authentication,
            @ModelAttribute ProfileUpdateRequest request) {
        
        ProfileResponse updatedProfile = userService.updateProfile(authentication.getName(), request);
        return ResponseEntity.ok(ApiResponse.success("Profile updated successfully", updatedProfile));
    }
}
