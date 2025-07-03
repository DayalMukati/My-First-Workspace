# .devcontainer/Dockerfile
FROM node:18

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y python3-pip curl gnupg && \
    npm install -g n8n

# Create working directories
RUN mkdir -p /root/.n8n /workflows

# Copy custom startup script (copied from repo root, not inside .devcontainer)
COPY init.sh /init.sh
RUN chmod +x /init.sh

CMD ["/init.sh"]