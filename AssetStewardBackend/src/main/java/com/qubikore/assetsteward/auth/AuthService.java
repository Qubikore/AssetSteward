package com.qubikore.assetsteward.auth;

import com.qubikore.assetsteward.auth.dto.AuthRequest;
import com.qubikore.assetsteward.auth.dto.AuthResponse;
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
    private final org.springframework.jdbc.core.JdbcTemplate jdbcTemplate;

    public AuthService(UserRepository repository, PasswordEncoder passwordEncoder, JwtService jwtService, AuthenticationManager authenticationManager, org.springframework.jdbc.core.JdbcTemplate jdbcTemplate) {
        this.repository = repository;
        this.passwordEncoder = passwordEncoder;
        this.jwtService = jwtService;
        this.authenticationManager = authenticationManager;
        this.jdbcTemplate = jdbcTemplate;
    }

    @jakarta.annotation.PostConstruct
    public void initSuperAdmin() {
        try {
            jdbcTemplate.execute("ALTER TABLE users DROP CONSTRAINT IF EXISTS users_role_check");
        } catch (Exception e) {
            System.out.println("Could not drop constraint: " + e.getMessage());
        }

        if (repository.findByEmail("admin@gmail.com").isEmpty()) {
            User admin = new User(
                "Super",
                "Admin",
                "admin@gmail.com",
                passwordEncoder.encode("123123"),
                Role.SUPER_ADMIN
            );
            repository.save(admin);
        }
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
