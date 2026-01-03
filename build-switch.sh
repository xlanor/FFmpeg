#!/bin/bash
# Build script for switch-ffmpeg 8.0
# Builds using Docker with devkitpro image

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IMAGE_NAME="switch-ffmpeg-build"

echo "Building switch-ffmpeg 8.0..."
echo "Script directory: $SCRIPT_DIR"

# Build the Docker image
echo "Building Docker image..."
docker build -t "$IMAGE_NAME" "$SCRIPT_DIR"

echo ""
echo "==================================="
echo "Build completed successfully!"
echo "==================================="
echo ""
echo "To extract the built libraries, run:"
echo "  docker create --name tmp-ffmpeg $IMAGE_NAME"
echo "  docker cp tmp-ffmpeg:/opt/devkitpro/portlibs/switch/lib ./lib-output"
echo "  docker cp tmp-ffmpeg:/opt/devkitpro/portlibs/switch/include ./include-output"
echo "  docker rm tmp-ffmpeg"
