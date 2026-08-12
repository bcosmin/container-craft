# [SNIPPET_ID: security/tls-certs]
# Description: Manages custom CA certificates for secure corporate environments.

# Copy custom CA certificates into the system trust store
# Assumes custom certificates are placed in a 'certs/' directory relative to the build context
COPY certs/*.crt /usr/local/share/ca-certificates/

# Update the system certificate store
# (Works for Debian/Ubuntu; Alpine uses update-ca-certificates as well)
RUN update-ca-certificates