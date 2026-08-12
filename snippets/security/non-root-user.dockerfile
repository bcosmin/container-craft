# [SNIPPET_ID: security/non-root-user]
# Description: Creates a secure non-root user and group, preparing the environment.
# Note: Ensure USER_ID and GROUP_ID can be overridden via build args if matching host permissions is needed.

ARG USER_ID=10001
ARG GROUP_ID=10001
ARG USERNAME=appuser

# Create a system group and user with a specific UID/GID
RUN groupadd -g ${GROUP_ID} ${USERNAME} && \
    useradd -l -u ${USER_ID} -g ${USERNAME} -m -s /bin/bash ${USERNAME}

# Set a working directory with proper ownership
WORKDIR /app
RUN chown -R ${USERNAME}:${USERNAME} /app

# Switch to the non-root user by default for subsequent layers and runtime
USER ${USERNAME}