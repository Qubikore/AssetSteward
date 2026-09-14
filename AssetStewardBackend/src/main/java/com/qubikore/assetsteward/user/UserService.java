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
    private final org.springframework.security.crypto.password.PasswordEncoder passwordEncoder;

    @Value("${app.backend-url:http://localhost:8080}")
    private String backendUrl;

    public UserService(UserRepository userRepository, FileStorageService fileStorageService, org.springframework.security.crypto.password.PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.fileStorageService = fileStorageService;
        this.passwordEncoder = passwordEncoder;
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

    public java.util.List<ProfileResponse> getUsersForDashboard(User currentUser) {
        if (currentUser.getRole() == Role.SUPER_ADMIN) {
            return userRepository.findAll().stream()
                    .filter(u -> u.getRole() != Role.SUPER_ADMIN)
                    .map(u -> new ProfileResponse(u, backendUrl))
                    .toList();
        } else if (currentUser.getRole() == Role.HR) {
            return userRepository.findAll().stream()
                    .filter(u -> u.getRole() == Role.USER)
                    .map(u -> new ProfileResponse(u, backendUrl))
                    .toList();
        } else {
            throw new RuntimeException("Unauthorized to view dashboard");
        }
    }

    public ProfileResponse createUser(com.qubikore.assetsteward.auth.dto.RegisterRequest request, User currentUser) {
        Role newRole = request.getRole() != null ? request.getRole() : Role.USER;
        
        if (currentUser.getRole() == Role.HR) {
            if (newRole != Role.USER) {
                throw new RuntimeException("HR can only create USER");
            }
        } else if (currentUser.getRole() == Role.SUPER_ADMIN) {
            if (newRole == Role.SUPER_ADMIN) {
                throw new RuntimeException("Cannot create another SUPER_ADMIN");
            }
        } else {
            throw new RuntimeException("Only SUPER_ADMIN and HR can create users");
        }

        if (userRepository.findByEmail(request.getEmail()).isPresent()) {
            throw new RuntimeException("Email is already in use");
        }
        
        User user = new User(
                request.getFirstname(),
                request.getLastname(),
                request.getEmail(),
                passwordEncoder.encode(request.getPassword()),
                newRole
        );
        userRepository.save(user);
        
        return new ProfileResponse(user, backendUrl);
    }
}
