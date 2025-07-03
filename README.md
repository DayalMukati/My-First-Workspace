# 🚀 n8n Codespace Template - FAST Setup (30 seconds!)

This repository sets up an [n8n](https://n8n.io) self-hosted environment inside GitHub Codespaces using Docker Compose with automatic workflow import in **~30 seconds** instead of 3+ minutes.

## ⚡ Performance Optimizations
- **Pre-built Universal Image**: Uses GitHub's optimized universal image instead of custom Ubuntu 22.04
- **Docker-outside-of-Docker**: Eliminates docker-in-docker overhead
- **Reduced Timeouts**: 15s Docker check (vs 60s), 30s n8n startup (vs 120s)
- **Parallel Workflow Import**: All workflows import simultaneously
- **Faster Health Checks**: 2s intervals instead of 5s

## ✅ Features
- **Lightning-fast setup** in GitHub Codespace (~30 seconds)
- **Optimized container** using GitHub's universal devcontainer image
- **Auto-starts n8n** on port `5678` with health checks
- **Auto-imports** all `.json` workflows from `/workflows` folder in parallel
- **Port forwarding** automatically configured for Codespace
- **Basic authentication** pre-configured for security

## 📁 Folder Structure
```
📦n8n-codespace-template/
├── .devcontainer/
│   └── devcontainer.json   # Optimized GitHub Codespace configuration
├── init.sh                 # Fast bootstrap script (<30s)
├── docker-compose.yml      # n8n container orchestration
├── workflows/              # Add your n8n workflow JSON files here
│   └── sample.json         # Example workflow (empty template)
└── README.md              # This file
```

## 🧠 How It Works (FAST!)
1. **GitHub Codespace starts** using optimized universal image (no custom builds)
2. **Docker-outside-of-docker** provides instant Docker access
3. **Fast init script** runs automatically:
   - Quick Docker daemon check (15s max)
   - Starts n8n using Docker Compose
   - Fast health check with 2s intervals (30s max)
   - Parallel import of all workflows from `/workflows` folder
4. **Port 5678** is automatically forwarded and accessible

## 📦 Quick Start
1. **Click "Use this template"** on GitHub
2. **Open in GitHub Codespace** (green "Code" button → Codespaces tab)
3. **Wait ~30 seconds** for automatic setup ⚡
4. **Access n8n** via the forwarded port notification or `http://localhost:5678`

## 📝 Adding Workflows
1. Export your workflows from an existing n8n instance as JSON
2. Place the `.json` files in the `/workflows` folder
3. Restart the Codespace or run `bash init.sh` to import them (in parallel!)

## 🔐 Default Credentials
```
Username: admin
Password: adminpassword
```

⚠️ **Security Note**: Change these credentials in `docker-compose.yml` before using in production!

## 🛠 Manual Commands
If you need to restart or manage the setup manually:

```bash
# Restart n8n
docker-compose restart

# View logs
docker-compose logs -f

# Stop n8n
docker-compose down

# Full restart with workflow import (fast!)
bash init.sh
```

## 🔧 Customization
- **Change credentials**: Edit environment variables in `docker-compose.yml`
- **Custom n8n settings**: Add environment variables to `docker-compose.yml`
- **Adjust timeouts**: Modify timeout values in `init.sh` if needed

## ⚡ Performance Notes
- **Before**: 3+ minutes setup time with Ubuntu 22.04 + docker-in-docker
- **After**: ~30 seconds with universal image + optimized scripts
- **Key optimizations**:
  - Universal devcontainer image (no build time)
  - Docker-outside-of-docker (faster Docker access)
  - Reduced timeout periods
  - Parallel workflow imports
  - Faster health check intervals

## 🐛 Troubleshooting
- **Port not forwarded**: Check Codespace ports tab and ensure 5678 is listed
- **n8n won't start**: Check `docker-compose logs n8n` for error messages
- **Workflows not importing**: Ensure JSON files are valid n8n exports
- **Still slow?**: Check your Codespace region and try recreating

---

**Enjoy automating in the cloud at lightning speed!** ⚡🎯✨
