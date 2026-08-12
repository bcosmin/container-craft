# [SNIPPET_ID: base/alpine]
# Description: Minimalist base image using Alpine Linux with essential updates.
# Usage: Set ALPINE_VERSION via ARG during build if needed.

ARG ALPINE_VERSION=3.20
FROM alpine:${ALPINE_VERSION}

LABEL maintainer="container-craft"

# Update package index and install essential certificates and timezone data.
# Cleaning up the cache to keep the image layer small.
RUN apk update && \
    apk add --no-cache ca-certificates tzdata && \
    rm -rf /var/cache/apk/*