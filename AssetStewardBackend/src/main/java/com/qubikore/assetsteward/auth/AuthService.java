package com.qubikore.assetsteward.auth;

import com.qubikore.assetsteward.auth.dto.AuthRequest;
import com.qubikore.assetsteward.auth.dto.AuthResponse;
import com.qubikore.assetsteward.auth.dto.RegisterRequest;
import com.qubikore.assetsteward.common.security.JwtService;
import com.qubikore.assetsteward.user.Role;
import com.qubikore.assetsteward.user.User;
import com.qubikore.assetsteward.user.UserRepository;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AuthService {

    private final UserRepository repository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;

    public AuthService(UserRepository repository, PasswordEncoder passwordEncoder, JwtService jwtService, AuthenticationManager authenticationManager) {
        this.repository = repository;
        this.passwordEncoder = passwordEncoder;
        this.jwtService = jwtService;
        this.authenticationManager = authenticationManager;
    }

    public AuthResponse register(RegisterRequest request) {
        
        if (repository.findByEmail(request.getEmail()).isPresent()) {
            throw new RuntimeException("Email is already in use");
        }
        
        var user = new User(
                request.getFirstname(),
                request.getLastname(),
                request.getEmail(),
                passwordEncoder.encode(request.getPassword()),
                Role.USER
        );
        repository.save(user);
        
        var jwtToken = jwtService.generateToken(user, request.isRememberMe());
        double expiresAt = request.isRememberMe() ? 2592000.0 : 86400.0;
        return new AuthResponse(jwtToken, "bearer", expiresAt);
    }

    public AuthResponse authenticate(AuthRequest request) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.getEmail(),
                        request.getPassword()
                )
        );
        
        var user = repository.findByEmail(request.getEmail())
                .orElseThrow();
                
        var jwtToken = jwtService.generateToken(user, request.isRememberMe());
        double expiresAt = request.isRememberMe() ? 2592000.0 : 86400.0;
        return new AuthResponse(jwtToken, "bearer", expiresAt);
    }
}
