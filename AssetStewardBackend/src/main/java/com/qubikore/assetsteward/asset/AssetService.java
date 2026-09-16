package com.qubikore.assetsteward.asset;

import com.qubikore.assetsteward.asset.dto.AssetAssignmentRequest;
import com.qubikore.assetsteward.asset.dto.AssetRequest;
import com.qubikore.assetsteward.asset.dto.AssetResponse;
import com.qubikore.assetsteward.category.Category;
import com.qubikore.assetsteward.category.CategoryRepository;
import com.qubikore.assetsteward.location.Location;
import com.qubikore.assetsteward.location.LocationRepository;
import com.qubikore.assetsteward.user.Role;
import com.qubikore.assetsteward.user.User;
import com.qubikore.assetsteward.user.UserRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class AssetService {

    private final AssetRepository assetRepository;
    private final CategoryRepository categoryRepository;
    private final LocationRepository locationRepository;
    private final AssignmentRepository assignmentRepository;
    private final UserRepository userRepository;

    public AssetService(AssetRepository assetRepository, CategoryRepository categoryRepository, LocationRepository locationRepository, AssignmentRepository assignmentRepository, UserRepository userRepository) {
        this.assetRepository = assetRepository;
        this.categoryRepository = categoryRepository;
        this.locationRepository = locationRepository;
        this.assignmentRepository = assignmentRepository;
        this.userRepository = userRepository;
    }

    public AssetResponse createAsset(AssetRequest request, User currentUser) {
        Asset asset = new Asset();
        asset.setAssetCode(request.getAssetCode());
        asset.setName(request.getName());
        asset.setSerialNumber(request.getSerialNumber());
        asset.setPurchaseDate(request.getPurchaseDate());
        asset.setPurchasePrice(request.getPurchasePrice());
        asset.setVendor(request.getVendor());
        asset.setCreatedBy(currentUser);

        if (request.getCategoryId() != null) {
            Category cat = categoryRepository.findById(request.getCategoryId()).orElse(null);
            asset.setCategory(cat);
        }

        if (request.getLocationId() != null) {
            Location loc = locationRepository.findById(request.getLocationId()).orElse(null);
            asset.setLocation(loc);
        }

        if (currentUser.getRole() == Role.SUPER_ADMIN || currentUser.getRole() == Role.HR) {
            asset.setStatus(AssetStatus.AVAILABLE);
        } else {
            asset.setStatus(AssetStatus.PENDING_APPROVAL);
        }

        assetRepository.save(asset);
        return new AssetResponse(asset);
    }

    public AssetResponse approveAsset(Long assetId, User currentUser) {
        if (currentUser.getRole() != Role.SUPER_ADMIN && currentUser.getRole() != Role.HR) {
            throw new RuntimeException("Only HR or Admin can approve assets.");
        }

        Asset asset = assetRepository.findById(assetId)
                .orElseThrow(() -> new RuntimeException("Asset not found"));

        if (asset.getStatus() != AssetStatus.PENDING_APPROVAL) {
            throw new RuntimeException("Asset is not pending approval.");
        }

        asset.setStatus(AssetStatus.AVAILABLE);
        assetRepository.save(asset);
        return new AssetResponse(asset);
    }

    public void assignAsset(AssetAssignmentRequest request, User currentUser) {
        if (currentUser.getRole() != Role.SUPER_ADMIN && currentUser.getRole() != Role.HR) {
            throw new RuntimeException("Only HR or Admin can assign assets.");
        }

        Asset asset = assetRepository.findById(request.getAssetId())
                .orElseThrow(() -> new RuntimeException("Asset not found"));

        if (asset.getStatus() != AssetStatus.AVAILABLE && asset.getStatus() != AssetStatus.RETURNED) {
            throw new RuntimeException("Asset is not available for assignment.");
        }

        User assignedTo = userRepository.findById(request.getUserId())
                .orElseThrow(() -> new RuntimeException("User not found"));

        Assignment assignment = new Assignment();
        assignment.setAsset(asset);
        assignment.setAssignedTo(assignedTo);
        assignment.setAssignedBy(currentUser);
        assignment.setAssignedAt(LocalDateTime.now());

        assignmentRepository.save(assignment);

        asset.setStatus(AssetStatus.ASSIGNED);
        assetRepository.save(asset);
    }

    public List<AssetResponse> getAllAssets() {
        return assetRepository.findAll().stream()
                .map(AssetResponse::new)
                .collect(Collectors.toList());
    }
}
