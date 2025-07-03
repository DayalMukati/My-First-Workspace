# .devcontainer/Dockerfile
FROM node:18

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y python3-pip curl gnupg && \
    npm install -g n8n

# Create working directories
RUN mkdir -p /root/.n8n /workflows
WORKDIR /workflows

# Copy custom startup script
COPY .devcontainer/init.sh /init.sh
RUN chmod +x /init.sh

CMD ["/init.sh"]
