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
    private final com.qubikore.assetsteward.department.DepartmentRepository departmentRepository;
    private final AssignmentRepository assignmentRepository;
    private final UserRepository userRepository;
    private final com.qubikore.assetsteward.assethistory.AssetHistoryService assetHistoryService;

    public AssetService(AssetRepository assetRepository, CategoryRepository categoryRepository, LocationRepository locationRepository, com.qubikore.assetsteward.department.DepartmentRepository departmentRepository, AssignmentRepository assignmentRepository, UserRepository userRepository, com.qubikore.assetsteward.assethistory.AssetHistoryService assetHistoryService) {
        this.assetRepository = assetRepository;
        this.categoryRepository = categoryRepository;
        this.locationRepository = locationRepository;
        this.departmentRepository = departmentRepository;
        this.assignmentRepository = assignmentRepository;
        this.userRepository = userRepository;
        this.assetHistoryService = assetHistoryService;
    }

    public AssetResponse createAsset(AssetRequest request, User currentUser) {
        Asset asset = new Asset();
        asset.setAssetCode(request.getAssetCode());
        asset.setName(request.getName());
        asset.setSerialNumber(request.getSerialNumber());
        asset.setPurchaseDate(request.getPurchaseDate());
        asset.setExpireDate(request.getExpireDate());
        asset.setPurchasePrice(request.getPurchasePrice());
        asset.setVendor(request.getVendor());
        if (request.getQuantity() != null) {
            asset.setQuantity(request.getQuantity());
        }
        asset.setCreatedBy(currentUser);
        asset.setOrganization(currentUser.getOrganization());


        if (request.getCategoryId() != null) {
            Category cat = categoryRepository.findById(request.getCategoryId()).orElse(null);
            asset.setCategory(cat);
        }

        if (request.getLocationId() != null) {
            Location loc = locationRepository.findById(request.getLocationId()).orElse(null);
            asset.setLocation(loc);
        }

        if (request.getDepartmentId() != null) {
            com.qubikore.assetsteward.department.Department dept = departmentRepository.findById(request.getDepartmentId()).orElse(null);
            asset.setDepartment(dept);
        }

        if (currentUser.getRole() == Role.SUPER_ADMIN || currentUser.getRole() == Role.HR) {
            asset.setStatus(AssetStatus.AVAILABLE);
        } else {
            asset.setStatus(AssetStatus.PENDING_APPROVAL);
        }

        assetRepository.save(asset);
        assetHistoryService.logAction(asset, currentUser, "CREATED", "Asset registered into the system.");
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
        assetHistoryService.logAction(asset, currentUser, "APPROVED", "Asset request approved by admin/HR.");
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

        if (request.getLocationId() != null) {
            Location loc = locationRepository.findById(request.getLocationId()).orElse(null);
            if (loc != null) {
                asset.setLocation(loc);
            }
        }


        assignmentRepository.save(assignment);

        asset.setStatus(AssetStatus.ASSIGNED);
        assetRepository.save(asset);
        
        assetHistoryService.logAction(asset, currentUser, "ASSIGNED", "Asset assigned to user: " + assignedTo.getEmail());
    }

    public void transferAsset(AssetAssignmentRequest request, User currentUser) {
        if (currentUser.getRole() != Role.SUPER_ADMIN && currentUser.getRole() != Role.HR) {
            throw new RuntimeException("Only HR or Admin can transfer assets.");
        }

        Asset asset = assetRepository.findById(request.getAssetId())
                .orElseThrow(() -> new RuntimeException("Asset not found"));

        if (asset.getStatus() != AssetStatus.ASSIGNED) {
            throw new RuntimeException("Asset is not currently assigned, cannot transfer.");
        }

        // Find the current active assignment
        Assignment currentAssignment = assignmentRepository.findAll().stream()
                .filter(a -> a.getAsset().getId().equals(asset.getId()) && a.getReturnedAt() == null)
                .findFirst()
                .orElseThrow(() -> new RuntimeException("No active assignment found for this asset."));

        // Mark current as returned
        currentAssignment.setReturnedAt(LocalDateTime.now());
        assignmentRepository.save(currentAssignment);

        // Assign to new user
        User assignedTo = userRepository.findById(request.getUserId())
                .orElseThrow(() -> new RuntimeException("New user not found"));

        Assignment newAssignment = new Assignment();
        newAssignment.setAsset(asset);
        newAssignment.setAssignedTo(assignedTo);
        newAssignment.setAssignedBy(currentUser);
        newAssignment.setAssignedAt(LocalDateTime.now());

        assignmentRepository.save(newAssignment);

        assetHistoryService.logAction(asset, currentUser, "TRANSFERRED", "Asset transferred from " + currentAssignment.getAssignedTo().getEmail() + " to " + assignedTo.getEmail());
    }

    public List<com.qubikore.assetsteward.asset.dto.AssetLabelResponse> getAssetLabels(User currentUser, com.qubikore.assetsteward.asset.QRCodeService qrCodeService) {
        return assetRepository.findByOrganization(currentUser.getOrganization()).stream()
                .map(asset -> {
                    try {
                        byte[] qrBytes = qrCodeService.generateQRCodeImage(asset.getAssetCode(), 200, 200);
                        String base64Qr = java.util.Base64.getEncoder().encodeToString(qrBytes);
                        return new com.qubikore.assetsteward.asset.dto.AssetLabelResponse(asset, "data:image/png;base64," + base64Qr);
                    } catch (Exception e) {
                        throw new RuntimeException("Failed to generate QR code for asset: " + asset.getAssetCode());
                    }
                }).collect(java.util.stream.Collectors.toList());
    }

    public List<AssetResponse> getAllAssets(Long categoryId, Long locationId, Long departmentId, String status, String search, User currentUser) {
        java.util.stream.Stream<Asset> stream = assetRepository.findByOrganization(currentUser.getOrganization()).stream();

        if (categoryId != null) {
            stream = stream.filter(a -> a.getCategory() != null && a.getCategory().getId().equals(categoryId));
        }
        if (locationId != null) {
            stream = stream.filter(a -> a.getLocation() != null && a.getLocation().getId().equals(locationId));
        }
        if (departmentId != null) {
            stream = stream.filter(a -> a.getDepartment() != null && a.getDepartment().getId().equals(departmentId));
        }
        if (status != null && !status.trim().isEmpty()) {
            stream = stream.filter(a -> a.getStatus().name().equalsIgnoreCase(status));
        }
        if (search != null && !search.trim().isEmpty()) {
            String lowerSearch = search.toLowerCase();
            stream = stream.filter(a -> 
                (a.getName() != null && a.getName().toLowerCase().contains(lowerSearch)) ||
                (a.getAssetCode() != null && a.getAssetCode().toLowerCase().contains(lowerSearch)) ||
                (a.getSerialNumber() != null && a.getSerialNumber().toLowerCase().contains(lowerSearch))
            );
        }

        return stream.map(AssetResponse::new).collect(Collectors.toList());
    }

    public List<com.qubikore.assetsteward.asset.dto.AssignmentResponse> getAllAssignments(String status, User currentUser) {
        java.util.stream.Stream<Assignment> stream = assignmentRepository.findAll().stream().filter(a -> a.getAsset() != null && a.getAsset().getOrganization() != null && a.getAsset().getOrganization().getId().equals(currentUser.getOrganization().getId()));
        
        if ("active".equalsIgnoreCase(status)) {
            stream = stream.filter(a -> a.getReturnedAt() == null);
        } else if ("returned".equalsIgnoreCase(status)) {
            stream = stream.filter(a -> a.getReturnedAt() != null);
        }

        return stream.map(com.qubikore.assetsteward.asset.dto.AssignmentResponse::new)
                .collect(Collectors.toList());
    }

    public AssetResponse updateAsset(Long assetId, AssetRequest request, User currentUser) {
        Asset asset = assetRepository.findById(assetId)
                .orElseThrow(() -> new RuntimeException("Asset not found"));
        
        if (asset.getOrganization() == null || !asset.getOrganization().getId().equals(currentUser.getOrganization().getId())) {
            throw new RuntimeException("Asset does not belong to your organization");
        }

        if (request.getName() != null) asset.setName(request.getName());
        if (request.getSerialNumber() != null) asset.setSerialNumber(request.getSerialNumber());
        if (request.getPurchaseDate() != null) asset.setPurchaseDate(request.getPurchaseDate());
        if (request.getExpireDate() != null) asset.setExpireDate(request.getExpireDate());
        if (request.getPurchasePrice() != null) asset.setPurchasePrice(request.getPurchasePrice());
        if (request.getVendor() != null) asset.setVendor(request.getVendor());
        if (request.getQuantity() != null) asset.setQuantity(request.getQuantity());

        if (request.getCategoryId() != null) {
            Category cat = categoryRepository.findById(request.getCategoryId()).orElse(null);
            asset.setCategory(cat);
        }

        if (request.getLocationId() != null) {
            Location loc = locationRepository.findById(request.getLocationId()).orElse(null);
            asset.setLocation(loc);
        }

        if (request.getDepartmentId() != null) {
            com.qubikore.assetsteward.department.Department dept = departmentRepository.findById(request.getDepartmentId()).orElse(null);
            asset.setDepartment(dept);
        }

        assetRepository.save(asset);
        assetHistoryService.logAction(asset, currentUser, "UPDATED", "Asset details updated.");
        return new AssetResponse(asset);
    }

    public void deleteAsset(Long assetId, User currentUser) {
        Asset asset = assetRepository.findById(assetId)
                .orElseThrow(() -> new RuntimeException("Asset not found"));
        
        if (asset.getOrganization() == null || !asset.getOrganization().getId().equals(currentUser.getOrganization().getId())) {
            throw new RuntimeException("Asset does not belong to your organization");
        }

        assetRepository.delete(asset);
    }
}
