# [SNIPPET_ID: tools/git/install-git]
# Description: Installs Git client with minimal overhead.
# Compatibility: Ubuntu / Debian based images.

RUN apt-get update && \
    apt-get install -y --no-install-recommends git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*