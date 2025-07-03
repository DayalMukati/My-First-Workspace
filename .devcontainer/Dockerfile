FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Install basic dependencies
RUN apt-get update && \
    apt-get install -y \
      curl \
      ca-certificates \
      jq \
      && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /workspaces/n8n-codespace-template
