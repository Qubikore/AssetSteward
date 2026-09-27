#!/bin/bash
sed -i '' -e '/^}$/d' src/main/java/com/qubikore/assetsteward/asset/AssetController.java
echo "}" >> src/main/java/com/qubikore/assetsteward/asset/AssetController.java
