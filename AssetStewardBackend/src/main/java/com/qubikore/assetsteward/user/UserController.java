package com.qubikore.assetsteward.user;

import com.qubikore.assetsteward.common.dto.ApiResponse;
import com.qubikore.assetsteward.auth.dto.RegisterRequest;
import com.qubikore.assetsteward.user.dto.ProfileResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;

import java.util.List;

@RestController
@RequestMapping("/api/v1/users")
@SecurityRequirement(name = "Bearer Authentication")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping
    public ResponseEntity<ApiResponse<List<ProfileResponse>>> getUsers(@AuthenticationPrincipal User currentUser) {
        List<ProfileResponse> users = userService.getUsersForDashboard(currentUser);
        return ResponseEntity.ok(ApiResponse.success("Users fetched successfully", users));
    }

    @PostMapping
    public ResponseEntity<ApiResponse<ProfileResponse>> createUser(
            @RequestBody RegisterRequest request,
            @AuthenticationPrincipal User currentUser) {
        ProfileResponse newUser = userService.createUser(request, currentUser);
        return ResponseEntity.ok(ApiResponse.success("User created successfully", newUser));
    }
}
