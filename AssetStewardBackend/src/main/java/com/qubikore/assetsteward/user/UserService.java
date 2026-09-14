package com.qubikore.assetsteward.user;

import com.qubikore.assetsteward.common.exception.ResourceNotFoundException;
import com.qubikore.assetsteward.common.service.FileStorageService;
import com.qubikore.assetsteward.user.dto.ProfileResponse;
import com.qubikore.assetsteward.user.dto.ProfileUpdateRequest;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final FileStorageService fileStorageService;

    @Value("${app.backend-url:http://localhost:8080}")
    private String backendUrl;

    public UserService(UserRepository userRepository, FileStorageService fileStorageService) {
        this.userRepository = userRepository;
        this.fileStorageService = fileStorageService;
    }

    public ProfileResponse getUserProfile(String email) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
        return new ProfileResponse(user, backendUrl);
    }

    public ProfileResponse updateProfile(String email, ProfileUpdateRequest request) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));

        if (request.getFirstname() != null && !request.getFirstname().trim().isEmpty()) {
            user.setFirstname(request.getFirstname());
        }

        if (request.getLastname() != null && !request.getLastname().trim().isEmpty()) {
            user.setLastname(request.getLastname());
        }

        if (request.getGender() != null && !request.getGender().trim().isEmpty()) {
            user.setGender(request.getGender());
        }

        if (request.getDob() != null) {
            user.setDob(request.getDob());
        }

        if (request.getProfile_picture() != null && !request.getProfile_picture().isEmpty()) {
            String pictureUrl = fileStorageService.storeFile(request.getProfile_picture());
            user.setProfilePicture(pictureUrl);
        }

        userRepository.save(user);
        return new ProfileResponse(user, backendUrl);
    }
}
