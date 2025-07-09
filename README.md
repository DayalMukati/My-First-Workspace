# 🚀 n8n Codespace Template (Auto Import Workflows)

This repository sets up an [n8n](https://n8n.io) self-hosted environment inside GitHub Codespaces using Docker Compose with automatic workflow import.

## ✅ Features
- **One-click setup** in GitHub Codespace
- **Docker-outside-of-Docker** support using devcontainer features  
- **Auto-starts n8n** on port `5678` with health checks
- **Auto-imports** all `.json` workflows from `/workflows` folder
- **Port forwarding** automatically configured for Codespace
- **Basic authentication** pre-configured for security

## 📁 Folder Structure
```
📦n8n-codespace-template/
├── .devcontainer/
│   └── devcontainer.json   # GitHub Codespace configuration
├── init.sh                 # Bootstraps n8n environment
├── docker-compose.yml      # n8n container orchestration
├── workflows/              # Add your n8n workflow JSON files here
│   └── sample.json         # Example workflow (empty template)
└── README.md              # This file
```

## 🧠 How It Works
1. **GitHub Codespace starts** using Ubuntu 22.04 base image
2. **Devcontainer features** install Docker-outside-of-Docker support
3. **Post-create command** runs `init.sh` automatically:
   - Waits for Docker daemon to be ready
   - Starts n8n using Docker Compose
   - Waits for health check (`/healthz`) to pass
   - Imports all `.json` workflows from `/workflows` folder
4. **Port 5678** is automatically forwarded and accessible

## 📦 Quick Start
1. **Click "Use this template"** on GitHub
2. **Open in GitHub Codespace** (green "Code" button → Codespaces tab)
3. **Wait for automatic setup** (2-3 minutes)
4. **Access n8n** via the forwarded port notification or `http://localhost:5678`

## 📝 Adding Workflows
1. Export your workflows from an existing n8n instance as JSON
2. Place the `.json` files in the `/workflows` folder
3. Restart the Codespace or run `bash init.sh` to import them

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

# Full restart with workflow import
bash init.sh
```

## 🔧 Customization
- **Change credentials**: Edit environment variables in `docker-compose.yml`
- **Custom n8n settings**: Add environment variables to `docker-compose.yml`

## 🐛 Troubleshooting
- **Port not forwarded**: Check Codespace ports tab and ensure 5678 is listed
- **n8n won't start**: Check `docker-compose logs n8n` for error messages
- **Workflows not importing**: Ensure JSON files are valid n8n exports

---

**Enjoy automating in the cloud!** 🎯✨
