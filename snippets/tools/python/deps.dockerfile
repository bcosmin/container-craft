# [SNIPPET_ID: tools/python/deps]
# Description: Installs Python dependencies into a virtual environment to avoid PEP 668 conflicts.

WORKDIR /app

# Create a virtual environment
RUN python -m venv /opt/venv

# Ensure the virtual environment is used for subsequent commands
ENV PATH="/opt/venv/bin:$PATH"

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt