#!/bin/bash

set -e

function error_exit {
  echo "❌ Error: $1" >&2
  exit 1
}

echo "🔍 Checking Docker availability..."
if ! command -v docker &> /dev/null; then
  error_exit "Docker not found. Please ensure Docker is properly installed."
fi

# Quick Docker daemon check (reduced timeout)
echo "⌛ Checking Docker daemon..."
timeout=15
count=0
while ! docker info > /dev/null 2>&1; do
  if [ $count -ge $timeout ]; then
    error_exit "Docker daemon not available within $timeout seconds"
  fi
  sleep 1
  ((count+=1))
done

echo "✅ Docker is ready!"

# Use docker compose (modern syntax)
COMPOSE_CMD="docker compose"
if ! docker compose version &> /dev/null 2>&1; then
  COMPOSE_CMD="docker-compose"
fi

if [ ! -d "./workflows" ]; then
  error_exit "Expected ./workflows directory does not exist. Please create it and add workflow JSON files."
fi

echo "🚀 Starting n8n via Docker Compose..."
$COMPOSE_CMD up -d || error_exit "Failed to start Docker Compose"

echo "⌛ Waiting for n8n to be ready..."
timeout=30  # Reduced from 120s
count=0
until curl -s -f http://localhost:5678/healthz > /dev/null 2>&1; do
  if [ $count -ge $timeout ]; then
    error_exit "n8n failed to start within $timeout seconds"
  fi
  echo "   n8n not ready yet, waiting... ($count/$timeout)"
  sleep 2  # Reduced from 5s
  ((count+=2))
done

echo "📥 Importing workflows..."
# Get the container ID once
container_id=$(docker ps -qf "ancestor=n8nio/n8n")
if [ -z "$container_id" ]; then
  echo "⚠️ Could not find n8n container to import workflows"
else
  # Import workflows in parallel for faster processing
  for file in ./workflows/*.json; do
    if [ -f "$file" ]; then
      echo "📄 Importing $(basename "$file")"
      docker exec "$container_id" n8n import:workflow --input "/workflows/$(basename "$file")" &
    fi
  done
  # Wait for all background imports to complete
  wait
fi

echo ""
echo "✅ n8n setup complete in ~30 seconds!"
echo "🌐 n8n is now available at: http://localhost:5678"
echo "🔐 Login credentials:"
echo "   Username: admin"
echo "   Password: adminpassword"
echo ""
echo "💡 Tip: The port should be automatically forwarded in GitHub Codespace"
