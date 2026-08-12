# [SNIPPET_ID: tools/aws/install-aws-cli]
# Description: Installs the official AWS CLI v2.
# Compatibility: Ubuntu / Debian based images (requires curl and unzip).

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl unzip && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip ./aws && \
    apt-get purge -y curl unzip && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*