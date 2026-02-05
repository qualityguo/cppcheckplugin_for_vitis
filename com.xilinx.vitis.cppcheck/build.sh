#!/bin/bash

# ========================================
# Vitis Cppcheck Plugin - Complete Build and Package Script
# ========================================

set -e

echo ""
echo "========================================"
echo "  Vitis Cppcheck Plugin"
echo "  Build and Distribution Package"
echo "========================================"
echo ""

# ========================================
# Configuration - Modify according to your environment
# ========================================

# Java installation path
if [ -z "$JAVA_HOME" ]; then
    # Windows Git Bash path
    JAVA_HOME="/d/Xilinx2021/Vitis/2021.1/tps/win64/jre11.0.2"

    # Linux path examples
    # JAVA_HOME="/usr/lib/jvm/java-11-openjdk"
    # JAVA_HOME="/opt/jdk-11"
fi

export JAVA_HOME=$(cygpath -w "$JAVA_HOME" 2>/dev/null || echo "$JAVA_HOME")
echo "JAVA_HOME: $JAVA_HOME"

# Maven installation path (optional)
# MAVEN_HOME="/d/Soft/apache-maven-3.9.12"

# ========================================

# Check Java
echo "[1/7] Checking Java environment..."

if [ ! -f "$JAVA_HOME/bin/java" ] && [ ! -f "$JAVA_HOME/jre/bin/java" ]; then
    echo ""
    echo "Error: Java not found"
    echo "JAVA_HOME: $JAVA_HOME"
    echo ""
    echo "Please edit this script and modify JAVA_HOME variable"
    echo ""
    echo "Common path examples:"
    echo "  Windows Git Bash: /d/Xilinx2021/Vitis/2021.1/tps/win64/jre11.0.2"
    echo "  Linux: /usr/lib/jvm/java-11-openjdk"
    echo "  Mac: /Library/Java/JavaVirtualMachines/jdk-11.jdk/Contents/Home"
    echo ""
    exit 1
fi

# Find java executable
if [ -f "$JAVA_HOME/bin/java" ]; then
    JAVA_BIN="$JAVA_HOME/bin/java"
else
    JAVA_BIN="$JAVA_HOME/jre/bin/java"
fi

JAVA_VER=$("$JAVA_BIN" -version 2>&1 | head -n 1)
echo "[OK] Java: $JAVA_HOME"
echo "     $JAVA_VER"
echo ""

# Check Maven
echo "[2/7] Checking Maven environment..."

if ! command -v mvn &> /dev/null; then
    if [ -n "$MAVEN_HOME" ]; then
        if [ -f "$MAVEN_HOME/bin/mvn" ]; then
            export PATH="$MAVEN_HOME/bin:$PATH"
            echo "[OK] Maven: $MAVEN_HOME"
        else
            echo "Error: Maven not found, please install or set MAVEN_HOME"
            echo "Download: https://maven.apache.org/download.cgi"
            echo ""
            exit 1
        fi
    else
        echo "Error: Maven not found, please install Maven"
        echo "Download: https://maven.apache.org/download.cgi"
        echo ""
        exit 1
    fi
else
    MVN_VER=$(mvn -version 2>&1 | head -n 1)
    echo "[OK] Maven ready"
fi

echo ""

# Get version info
VERSION="1.0.0"
DATE=$(date +%Y-%m-%d)
PACKAGE_NAME="vitis-cppcheck-plugin-${VERSION}-${DATE}"

echo "Build Configuration:"
echo "  Version: $VERSION"
echo "  Date: $DATE"
echo "  Package: $PACKAGE_NAME"
echo ""

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Maven Build
echo "[3/7] Building with Maven..."
echo "========================================"
echo ""

cd "$SCRIPT_DIR/com.xilinx.vitis.cppcheck.parent"
mvn clean package -DskipTests

if [ $? -ne 0 ]; then
    echo ""
    echo "========================================"
    echo "Build FAILED!"
    echo "========================================"
    echo ""
    exit 1
fi

echo ""
echo "[OK] Build successful!"
echo ""

# Create offline package
echo "[4/7] Creating offline installation package..."
echo "========================================"

REPOSITORY_DIR="$SCRIPT_DIR/com.xilinx.vitis.cppcheck.repository/target/repository"
OUTPUT_DIR="$SCRIPT_DIR/offline-package"
PLUGINS_DIR="$OUTPUT_DIR/plugins"
FEATURES_DIR="$OUTPUT_DIR/features"

# Clean old files
rm -rf "$OUTPUT_DIR"
mkdir -p "$PLUGINS_DIR"
mkdir -p "$FEATURES_DIR"

# Copy files
echo "Copying plugin files..."
cp "$REPOSITORY_DIR"/plugins/com.xilinx.vitis.cppcheck.core_*.jar "$PLUGINS_DIR/" 2>/dev/null
cp "$REPOSITORY_DIR"/plugins/com.xilinx.vitis.cppcheck.ui_*.jar "$PLUGINS_DIR/" 2>/dev/null
cp "$REPOSITORY_DIR"/plugins/com.xilinx.vitis.cppcheck.builder_*.jar "$PLUGINS_DIR/" 2>/dev/null
cp "$REPOSITORY_DIR"/features/com.xilinx.vitis.cppcheck.feature_*.jar "$FEATURES_DIR/" 2>/dev/null

echo ""
echo "[OK] Offline package created!"
echo ""

# Create distribution package structure
echo "[5/7] Creating distribution package structure..."
echo "========================================"

DIST_DIR="$SCRIPT_DIR/dist-package/$PACKAGE_NAME"
FINAL_ZIP="$SCRIPT_DIR/dist-package/$PACKAGE_NAME.zip"

# Clean old package
rm -rf "$DIST_DIR"
rm -f "$FINAL_ZIP"

# Create directories
mkdir -p "$DIST_DIR/p2-update-site"
mkdir -p "$DIST_DIR/dropins/cppcheck/plugins"
mkdir -p "$DIST_DIR/dropins/cppcheck/features"

# Copy files
echo "Copying p2 update site files..."
cp -r "$REPOSITORY_DIR"/* "$DIST_DIR/p2-update-site/"

echo "Copying dropins files..."
cp "$PLUGINS_DIR"/*.jar "$DIST_DIR/dropins/cppcheck/plugins/"
cp "$FEATURES_DIR"/*.jar "$DIST_DIR/dropins/cppcheck/features/"

echo ""
echo "[OK] Distribution structure created!"
echo ""

# Copy documentation
echo "[6/7] Copying documentation..."
echo "========================================"

cp "$SCRIPT_DIR/dist-package/README.md" "$DIST_DIR/" 2>/dev/null
cp "$SCRIPT_DIR/dist-package/INSTALLATION_GUIDE.md" "$DIST_DIR/" 2>/dev/null
cp "$SCRIPT_DIR/dist-package/USER_GUIDE.md" "$DIST_DIR/" 2>/dev/null
cp "$SCRIPT_DIR/dist-package/RELEASE_NOTES.md" "$DIST_DIR/" 2>/dev/null

echo ""
echo "[OK] Documentation copied!"
echo ""

# Create final ZIP
echo "[7/7] Creating final distribution ZIP..."
echo "========================================"
echo ""

cd "$SCRIPT_DIR/dist-package"

# Try different ZIP commands
if command -v zip &> /dev/null; then
    echo "Using zip command..."
    zip -rq "$PACKAGE_NAME.zip" "$PACKAGE_NAME"
    if [ $? -eq 0 ]; then
        echo "[OK] ZIP created successfully"
    else
        echo "ERROR: Failed to create ZIP"
        exit 1
    fi
elif command -v 7z &> /dev/null; then
    echo "Using 7-Zip..."
    7z a -tzip "$PACKAGE_NAME.zip" "$PACKAGE_NAME" > /dev/null
    if [ $? -eq 0 ]; then
        echo "[OK] ZIP created successfully"
    else
        echo "ERROR: Failed to create ZIP"
        exit 1
    fi
else
    echo "ERROR: No ZIP utility found"
    echo "Package directory is ready at: $DIST_DIR"
    echo "Please manually create a ZIP from this directory"
    exit 1
fi

echo ""
echo "========================================"
echo "ALL COMPLETE!"
echo "========================================"
echo ""
echo "Output Files:"
echo ""
echo "1. Distribution Package:"
echo "   $FINAL_ZIP"
ls -lh "$FINAL_ZIP" | awk '{print "   Size: " $5}'
echo ""
echo "2. Offline Package:"
echo "   $OUTPUT_DIR"
echo ""
echo "3. Maven Artifacts:"
echo "   $REPOSITORY_DIR"
echo ""
echo "Package Contents:"
echo "  - README.md (Quick Start Guide)"
echo "  - INSTALLATION_GUIDE.md (Detailed Installation)"
echo "  - USER_GUIDE.md (Complete User Manual)"
echo "  - RELEASE_NOTES.md (Release Information)"
echo "  - p2-update-site/ (For Install Software method)"
echo "  - dropins/cppcheck/ (For manual installation)"
echo ""
echo "This package is ready for distribution!"
echo ""
echo "========================================"
