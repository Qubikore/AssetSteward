package com.qubikore.assetsteward.common.service;

import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

@Service
public class FileStorageService {

    private final Path defaultFileStorageLocation;
    private final Path rootStorageLocation;

    public FileStorageService() {
        this.rootStorageLocation = Paths.get("uploads").toAbsolutePath().normalize();
        this.defaultFileStorageLocation = Paths.get("uploads/profiles").toAbsolutePath().normalize();

        try {
            Files.createDirectories(this.defaultFileStorageLocation);
        } catch (Exception ex) {
            throw new RuntimeException("Could not create the directory where the uploaded files will be stored.", ex);
        }
    }

    public String storeFile(MultipartFile file) {
        return storeFile(file, "profiles");
    }

    public String storeFile(MultipartFile file, String folder) {
        String originalFileName = StringUtils.cleanPath(file.getOriginalFilename());
        
        try {
            if (originalFileName.contains("..")) {
                throw new RuntimeException("Sorry! Filename contains invalid path sequence " + originalFileName);
            }

            Path targetFolder = this.rootStorageLocation.resolve(folder).normalize();
            Files.createDirectories(targetFolder);

            // Generate unique file name to avoid collisions
            String fileExtension = "";
            int lastIndex = originalFileName.lastIndexOf('.');
            if(lastIndex != -1) {
                fileExtension = originalFileName.substring(lastIndex);
            }
            
            String newFileName = UUID.randomUUID().toString() + fileExtension;
            Path targetLocation = targetFolder.resolve(newFileName);
            Files.copy(file.getInputStream(), targetLocation, StandardCopyOption.REPLACE_EXISTING);

            return "/uploads/" + folder + "/" + newFileName;
        } catch (IOException ex) {
            throw new RuntimeException("Could not store file " + originalFileName + ". Please try again!", ex);
        }
    }
}
