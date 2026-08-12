# [SNIPPET_ID: tools/node/deps]
# Description: Installs Node.js dependencies from package.json and package-lock.json.
# Note: Assumes package configuration files are present in the build context.

WORKDIR /app

# Copy dependency manifests first for layer caching
COPY package*.json ./

# Install production dependencies cleanly
RUN npm ci --omit=dev