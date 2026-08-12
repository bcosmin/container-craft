# [SNIPPET_ID: tools/java/install-java]
# Description: Installs Eclipse Temurin OpenJDK 21 (LTS), the standard runtime for enterprise Java applications.
# Compatibility: Ubuntu / Debian based images.

RUN apt-get update && \
    apt-get install -y --no-install-recommends wget apt-transport-https gnupg && \
    mkdir -p /etc/apt/keyrings && \
    wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor -o /etc/apt/keyrings/adoptium.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/adoptium.gpg] https://packages.adoptium.net/artifactory/deb $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/source.list.d/adoptium.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends temurin-21-jdk && \
    apt-get purge -y wget apt-transport-https && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set standard JAVA_HOME environment variable
ENV JAVA_HOME=/usr/lib/jvm/temurin-21-jdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"