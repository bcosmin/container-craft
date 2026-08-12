# [SNIPPET_ID: base/ubuntu]
# Description: Robust base image using Ubuntu LTS.
# Usage: Set UBUNTU_VERSION via ARG during build if needed.

ARG UBUNTU_VERSION=24.04
FROM ubuntu:${UBUNTU_VERSION}

LABEL maintainer="container-craft"

# Prevent interactive prompts during package installation.
ENV DEBIAN_FRONTEND=noninteractive

# Update apt repositories and install standard utility packages.
# Clean up apt lists to minimize image size.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    tzdata && \
    rm -rf /var/lib/apt/lists/*