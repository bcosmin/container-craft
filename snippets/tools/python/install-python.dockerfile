# [SNIPPET_ID: tools/python/install-python]
# Description: Installs Python 3.12 along with python3-pip and virtualenv support.
# Compatibility: Ubuntu / Debian based images.

ARG PYTHON_VERSION=3.12

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python${PYTHON_VERSION} \
    python${PYTHON_VERSION}-venv \
    python3-pip && \
    ln -sf /usr/bin/python${PYTHON_VERSION} /usr/bin/python && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*