package com.qubikore.assetsteward.user;

import com.qubikore.assetsteward.common.dto.ApiResponse;
import com.qubikore.assetsteward.user.dto.OrganizationResponse;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/organization")
@SecurityRequirement(name = "Bearer Authentication")
public class OrganizationController {

    @GetMapping("/me")
    public ResponseEntity<ApiResponse<OrganizationResponse>> getMyOrganization(
            @AuthenticationPrincipal User currentUser) {
        
        if (currentUser.getOrganization() == null) {
            return ResponseEntity.badRequest().body(ApiResponse.error(400, "User does not belong to any organization"));
        }
        
        OrganizationResponse response = new OrganizationResponse(currentUser.getOrganization());
        return ResponseEntity.ok(ApiResponse.success("Organization fetched successfully", response));
    }
}
