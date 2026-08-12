# [SNIPPET_ID: tools/go/install-go]
# Description: Installs Go runtime (latest stable version) and configures environment paths.
# Compatibility: Ubuntu / Debian based images.

ARG GO_VERSION=1.22.5

RUN apt-get update && \
    apt-get install -y --no-install-recommends wget curl && \
    wget https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz && \
    rm go${GO_VERSION}.linux-amd64.tar.gz && \
    apt-get purge -y wget && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set Go environment variables
ENV PATH="/usr/local/go/bin:${PATH}"
ENV GOPATH="/go"
ENV PATH="${GOPATH}/bin:${PATH}"

RUN mkdir -p "${GOPATH}/src" "${GOPATH}/bin"