#!/bin/sh

# Script to cross-compile SDL2 for x86_64 on an ARM64 macOS

# Configuration
BUILD_DIR="build"
INSTALL_DIR="../install"
TARGET_ARCH="x86_64"

# Create build directory
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# CMake configuration
cmake ".." \
    -DCMAKE_OSX_ARCHITECTURES="$TARGET_ARCH" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$INSTALL_DIR" \
    -DSDL_SHARED=ON \
    -DSDL_STATIC=OFF

if [ $? -ne 0 ]; then
  echo "Error: CMake configuration failed."
  exit 1
fi

# CMake build
cmake --build . --config Release --parallel $(nproc)

if [ $? -ne 0 ]; then
  echo "Error: CMake build failed."
  exit 1
fi

echo "SDL2 cross-compilation for $TARGET_ARCH successful."
cd ../..
