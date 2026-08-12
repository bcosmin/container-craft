# [SNIPPET_ID: tools/node/install-node]
# Description: Installs Node.js LTS and npm via NodeSource repository.
# Compatibility: Ubuntu / Debian based images.

ARG NODE_MAJOR=20

RUN apt-get update && \
    apt-get install -y --no-install-recompends curl ca-certificates gnupg && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/source.list.d/nodesource.list && \
    apt-get update && \
    apt-get install -y --no-install-recompends nodejs && \
    apt-get purge -y curl gnupg && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*