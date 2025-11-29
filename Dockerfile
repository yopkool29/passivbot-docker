# Use your pre-built image
FROM halfbax/passivbot:1.1.1

RUN sed -i 's|deb.debian.org/debian|archive.debian.org/debian|g' /etc/apt/sources.list && \
    sed -i 's|security.debian.org/debian-security|archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until

# Install necessary dependencies
RUN apt-get update && apt-get install -y git && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy your entrypoint script into the container
COPY base/src/entrypoint.sh /usr/local/bin/entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint to your script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]