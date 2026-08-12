#!/usr/bin/env bash
# [CONTAINER-CRAFT TEST SUITE] Automated validation for built images

set -euo pipefail

IMAGE_NAME="${1:-container-craft/fastapi-app:latest}"
CONTAINER_NAME="craft-test-container"

echo "[*] Running validation tests for image: $IMAGE_NAME"

# Clean up any leftover test containers
docker rm -f "$CONTAINER_NAME" 2>/dev/null || true

# 1. Start the container in detached mode
echo "[*] Starting test container..."
docker run -d --name "$CONTAINER_NAME" -p 9090:8080 "$IMAGE_NAME"

# Wait a few seconds for the app to spin up
sleep 3

# 2. Test HTTP health endpoint
echo "[*] Testing HTTP endpoint..."
RESPONSE=$(curl -s http://localhost:9090/)
echo "Response received: $RESPONSE"

if echo "$RESPONSE" | grep -q "success"; then
    echo "[PASS] HTTP health check passed!"
else
    echo "[FAIL] HTTP health check failed!"
    docker logs "$CONTAINER_NAME"
    docker rm -f "$CONTAINER_NAME"
    exit 1
fi

# 3. Test security: verify container is NOT running as root
echo "[*] Validating non-root security policy..."
CURRENT_USER=$(docker exec "$CONTAINER_NAME" whoami)
echo "Running as user: $CURRENT_USER"

if [ "$CURRENT_USER" != "root" ]; then
    echo "[PASS] Security check passed: Container is running as non-root ($CURRENT_USER)."
else
    echo "[FAIL] Security check failed: Container is running as root!"
    docker rm -f "$CONTAINER_NAME"
    exit 1
fi

# Clean up test container
docker rm -f "$CONTAINER_NAME"
echo "[+] All tests passed successfully!"
exit 0