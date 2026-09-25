#!/bin/bash
sed -i '' '/assignment.setAssignedAt(LocalDateTime.now());/a\
\
        if (request.getLocationId() != null) {\
            Location loc = locationRepository.findById(request.getLocationId()).orElse(null);\
            if (loc != null) {\
                asset.setLocation(loc);\
            }\
        }\
' src/main/java/com/qubikore/assetsteward/asset/AssetService.java
