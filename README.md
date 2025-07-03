# 🚀 n8n Codespace Template - Ubuntu 24 + Docker (30 seconds!)

This repository sets up an [n8n](https://n8n.io) self-hosted environment inside GitHub Codespaces using **preinstalled Ubuntu 24.04** with Docker for fast startup in **~30 seconds**.

## ⚡ Optimized Performance with Ubuntu 24
- **Preinstalled Ubuntu 24.04**: No custom image builds (much faster)
- **Docker-outside-of-Docker**: Optimized Docker access for Codespaces
- **Reduced Timeouts**: 10s Docker check, 20s n8n startup
- **Parallel Workflow Import**: All workflows import simultaneously
- **Modern Docker Compose**: Uses latest Docker features

## ✅ Features
- **Fast setup** in GitHub Codespace (~30 seconds)
- **Ubuntu 24.04** preinstalled devcontainer image
- **Auto-starts n8n** on port `5678` with health checks
- **Auto-imports** all `.json` workflows from `/workflows` folder in parallel
- **Port forwarding** automatically configured for Codespace
- **Basic authentication** pre-configured for security
- **Docker Compose** for reliable container management

## 📁 Folder Structure
```
📦n8n-codespace-template/
├── .devcontainer/
│   └── devcontainer.json   # Ubuntu 24.04 configuration
├── init.sh                 # Optimized bootstrap script (~30s)
├── package.json            # npm scripts for management
├── init-fast.sh            # Alternative Node.js approach
├── docker-compose.yml      # n8n container orchestration
├── workflows/              # Add your n8n workflow JSON files here
│   └── sample.json         # Example workflow (empty template)
└── README.md              # This file
```

## 🧠 How It Works (Ubuntu 24 + Docker)
1. **GitHub Codespace starts** using preinstalled Ubuntu 24.04 image (no build time)
2. **Docker-outside-of-docker** provides optimized Docker access
3. **Fast init script** runs automatically:
   - Quick Docker daemon check (10s max)
   - Starts n8n using Docker Compose
   - Fast health check with 2s intervals (20s max)
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

## 🛠 Management Commands
Docker-based management:

```bash
# Restart n8n
docker-compose restart

# View logs
docker-compose logs -f

# Stop n8n
docker-compose down

# Full restart with workflow import
bash init.sh

# Alternative: npm-based management
npm restart
npm run logs
npm run status
```

## 🔧 Customization
- **Change credentials**: Edit environment variables in `docker-compose.yml`
- **Custom n8n settings**: Add environment variables to `docker-compose.yml`
- **Adjust timeouts**: Modify timeout values in `init.sh` if needed

## ⚡ Performance Comparison
- **Custom Ubuntu 22.04 build**: 4+ minutes setup time
- **Ubuntu 24.04 preinstalled**: ~30 seconds with Docker
- **Direct Node.js approach**: ~15 seconds (alternative in `init-fast.sh`)
- **Speed improvement**: 8x faster with preinstalled image! 🚀

## 🎯 Why Ubuntu 24 is Faster
1. **No image building**: Uses Microsoft's prebuilt Ubuntu 24.04 image
2. **Optimized for Codespaces**: Image is pre-cached and optimized
3. **Latest packages**: Ubuntu 24.04 has newer, faster package versions
4. **Better Docker integration**: Improved Docker performance in newer Ubuntu
5. **Reduced initialization**: Less setup time for system components

## 🔄 Alternative Approaches
You can switch between different approaches by changing the `postCreateCommand` in `.devcontainer/devcontainer.json`:

- **Ubuntu 24 + Docker** (current): `bash ./init.sh`
- **Direct Node.js** (fastest): `bash ./init-fast.sh`

## 🐛 Troubleshooting
- **Port not forwarded**: Check Codespace ports tab and ensure 5678 is listed
- **n8n won't start**: Check `docker-compose logs n8n` for error messages
- **Workflows not importing**: Ensure JSON files are valid n8n exports
- **Still slow?**: Try the Node.js approach with `init-fast.sh`

---

**Enjoy automating in the cloud with Ubuntu 24 speed!** ⚡🎯✨
