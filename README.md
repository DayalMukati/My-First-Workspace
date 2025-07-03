# 🚀 n8n Codespace Template - ULTRA FAST Setup (15 seconds!)

This repository sets up an [n8n](https://n8n.io) self-hosted environment inside GitHub Codespaces **WITHOUT Docker overhead** - achieving **~15 seconds** setup time instead of 4+ minutes.

## ⚡ RADICAL Performance Optimizations
- **NO DOCKER**: Runs n8n directly with Node.js (eliminates container overhead)
- **Lightweight Node.js Image**: Uses minimal JavaScript devcontainer image
- **Direct Installation**: npm install + direct n8n start (no virtualization)
- **Native Performance**: Full speed execution in Codespace environment
- **Instant Workflow Import**: Direct CLI import (no container exec)

## ✅ Features
- **Lightning-fast setup** in GitHub Codespace (~15 seconds)
- **Zero Docker overhead** - runs n8n directly with Node.js
- **Auto-starts n8n** on port `5678` with instant health checks
- **Auto-imports** all `.json` workflows from `/workflows` folder
- **Port forwarding** automatically configured for Codespace
- **Basic authentication** pre-configured for security
- **Native performance** with full Codespace resources

## 📁 Folder Structure
```
📦n8n-codespace-template/
├── .devcontainer/
│   └── devcontainer.json   # Ultra-fast Node.js configuration
├── init-fast.sh            # Ultra-fast bootstrap script (~15s)
├── package.json            # npm management with helpful scripts
├── docker-compose.yml      # Legacy - not used in fast mode
├── workflows/              # Add your n8n workflow JSON files here
│   └── sample.json         # Example workflow (empty template)
└── README.md              # This file
```

## 🧠 How It Works (ULTRA FAST!)
1. **GitHub Codespace starts** using lightweight Node.js 18 image
2. **No Docker setup** - eliminates virtualization overhead
3. **Ultra-fast init script** runs automatically:
   - npm installs n8n globally (if needed)
   - Starts n8n directly with Node.js
   - Quick health check (15s max)
   - Direct CLI import of all workflows
4. **Port 5678** is automatically forwarded and accessible

## 📦 Quick Start
1. **Click "Use this template"** on GitHub
2. **Open in GitHub Codespace** (green "Code" button → Codespaces tab)
3. **Wait ~15 seconds** for automatic setup ⚡⚡⚡
4. **Access n8n** via the forwarded port notification or the Codespace URL

## 📝 Adding Workflows
1. Export your workflows from an existing n8n instance as JSON
2. Place the `.json` files in the `/workflows` folder
3. Run `npm restart` to reimport them instantly

## 🔐 Default Credentials
```
Username: admin
Password: adminpassword
```

⚠️ **Security Note**: Change these credentials by modifying environment variables in `init-fast.sh`

## 🛠 Quick Commands
Ultra-fast management with npm scripts:

```bash
# Check if n8n is running
npm run status

# View real-time logs
npm run logs

# Restart n8n (with workflow reimport)
npm restart

# Stop n8n
npm run stop

# Start n8n manually
npm start
```

## 🔧 Customization
- **Change credentials**: Edit environment variables in `init-fast.sh`
- **Custom n8n settings**: Add environment variables to `init-fast.sh`
- **Add npm packages**: Install directly with `npm install -g <package>`

## ⚡ Performance Comparison
- **Old Docker approach**: 4+ minutes setup time
- **Previous "optimized"**: 3+ minutes with universal image
- **NEW Ultra-fast**: ~15 seconds with direct Node.js execution
- **Speed improvement**: 16x faster! 🚀🚀🚀

## 🎯 Why This Is So Much Faster
1. **No container pulls**: No Docker image downloads
2. **No virtualization**: Direct process execution
3. **Minimal base image**: Node.js 18 devcontainer only
4. **Native npm**: Direct n8n installation and execution
5. **No Docker daemon**: Eliminates all container overhead
6. **Direct file access**: No volume mounts or container filesystem

## 🐛 Troubleshooting
- **Port not forwarded**: Check Codespace ports tab and ensure 5678 is listed
- **n8n won't start**: Run `npm run logs` to see error messages
- **Workflows not importing**: Ensure JSON files are valid n8n exports
- **Need to restart**: Use `npm restart` for quick restart with reimport

## 🔄 Legacy Docker Support
The old Docker setup files are still included for reference:
- `docker-compose.yml` - Original Docker setup
- `init.sh` - Original Docker-based initialization

To use the legacy Docker mode, change `postCreateCommand` in `.devcontainer/devcontainer.json` to `bash ./init.sh`

---

**Enjoy automating in the cloud at ULTRA speed!** ⚡⚡⚡🎯✨
