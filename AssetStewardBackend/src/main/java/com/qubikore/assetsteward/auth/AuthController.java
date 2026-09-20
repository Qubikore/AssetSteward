package com.qubikore.assetsteward.auth;

import com.qubikore.assetsteward.auth.dto.AuthRequest;
import com.qubikore.assetsteward.auth.dto.AuthResponse;
import com.qubikore.assetsteward.common.dto.ApiResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;

@RestController
@RequestMapping("/api/v1/auth")
public class AuthController {

    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping("/register")
    @SecurityRequirement(name = "Bearer Authentication")
    public ResponseEntity<ApiResponse<AuthResponse>> register(
            @RequestBody com.qubikore.assetsteward.auth.dto.RegisterRequest request,
            @org.springframework.security.core.annotation.AuthenticationPrincipal com.qubikore.assetsteward.user.User currentUser
    ) {
        return ResponseEntity.ok(ApiResponse.success("Registration successful", authService.register(request, currentUser)));
    }

    @PostMapping("/register-organization")
    public ResponseEntity<ApiResponse<AuthResponse>> registerOrganization(
            @RequestBody com.qubikore.assetsteward.auth.dto.RegisterOrganizationRequest request
    ) {
        return ResponseEntity.ok(ApiResponse.success("Organization created successfully", authService.registerOrganization(request)));
    }


    @PostMapping("/login")
    public ResponseEntity<ApiResponse<AuthResponse>> authenticate(@RequestBody AuthRequest request) {
        return ResponseEntity.ok(ApiResponse.success("Login successful", authService.authenticate(request)));
    }
}
