FROM mattrayner/lamp:latest-1804

# Zainstaluj wymagane narzędzia
RUN apt-get update && \
    apt-get install -y iputils-ping telnet netcat && \
    rm -rf /var/lib/apt/lists/*
