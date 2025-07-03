#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Function to print error and exit
function error_exit {
  echo "❌ Error: $1" >&2
  exit 1
}

# Ensure Docker is installed
if ! command -v docker &> /dev/null; then
  echo "Docker not found. Installing..."
  curl -fsSL https://get.docker.com | sh || error_exit "Docker installation failed"
fi

# Ensure Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
  echo "Docker Compose not found. Installing..."
  curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/bin/docker-compose || error_exit "Docker Compose download failed"
  chmod +x /usr/local/bin/docker-compose
  ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose || true
fi

# Ensure workflows folder exists
if [ ! -d "./workflows" ]; then
  error_exit "Expected ./workflows directory does not exist. Please create it and add workflow JSON files."
fi

# Start n8n using Docker Compose
echo "🚀 Starting n8n via Docker Compose..."
docker-compose up -d || error_exit "Failed to start Docker Compose"

# Wait for n8n to be ready
until curl -s http://localhost:5678/healthz > /dev/null; do
  echo "⌛ Waiting for n8n to start..."
  sleep 5
done

# Import workflows
echo "📥 Importing workflows..."
for file in ./workflows/*.json; do
  if [ -f "$file" ]; then
    echo "📄 Importing $file"
    docker exec $(docker ps -qf "ancestor=n8nio/n8n") n8n import:workflow --input "/workflows/$(basename $file)" || echo "⚠️ Failed to import $file"
  fi

done

echo "✅ n8n setup complete and workflows imported."
