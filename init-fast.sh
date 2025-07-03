#!/bin/bash

set -e

echo "🚀 Starting ultra-fast n8n setup (no Docker overhead)..."

# Install n8n globally if not already installed
if ! command -v n8n &> /dev/null; then
  echo "📦 Installing n8n via npm..."
  npm install -g n8n
fi

# Create n8n data directory
mkdir -p ~/.n8n

# Set n8n environment variables for Codespace
export N8N_HOST=0.0.0.0
export N8N_PORT=5678
export N8N_PROTOCOL=http
export N8N_BASIC_AUTH_ACTIVE=true
export N8N_BASIC_AUTH_USER=admin
export N8N_BASIC_AUTH_PASSWORD=adminpassword
export WEBHOOK_URL=https://$CODESPACE_NAME-5678.app.github.dev/

echo "⚡ Starting n8n directly..."
# Start n8n in background
nohup n8n start > ~/.n8n/n8n.log 2>&1 &
N8N_PID=$!

# Wait for n8n to be ready (much faster without Docker)
echo "⌛ Waiting for n8n to be ready..."
timeout=15  # Even shorter timeout since no container overhead
count=0
until curl -s -f http://localhost:5678/healthz > /dev/null 2>&1; do
  if [ $count -ge $timeout ]; then
    echo "❌ n8n failed to start within $timeout seconds"
    echo "📋 Logs:"
    tail ~/.n8n/n8n.log
    exit 1
  fi
  echo "   n8n starting... ($count/$timeout)"
  sleep 1
  ((count+=1))
done

echo "📥 Importing workflows..."
# Import workflows directly using n8n CLI (fastest method)
for file in ./workflows/*.json; do
  if [ -f "$file" ]; then
    echo "📄 Importing $(basename "$file")"
    n8n import:workflow --input "$file" &
  fi
done
wait

echo ""
echo "✅ n8n setup complete in ~15 seconds! (No Docker overhead)"
echo "🌐 n8n is now available at: https://$CODESPACE_NAME-5678.app.github.dev/"
echo "🔐 Login credentials:"
echo "   Username: admin"
echo "   Password: adminpassword"
echo ""
echo "💡 The port is automatically forwarded in GitHub Codespace"
echo "📋 Logs available at: ~/.n8n/n8n.log" 