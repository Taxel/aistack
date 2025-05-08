# 🧠 aistack

A local, self-hosted AI stack featuring Open WebUI, Ollama, SearXNG, Jupyter, and Pipelines. Designed for privacy, extensibility, and full control over how you interact with powerful language and image models — all without relying on cloud APIs or third-party services.

---

## ✨ Motivation

I wanted a **personal AI playground** that runs completely on my own hardware. No more sending prompts or sensitive data to external APIs. The goals:

- 🛠️ Full control of the stack
- 🔒 Local-only privacy
- 🚀 GPU-accelerated performance
- 📦 Easily extendable (LLMs now, Stable Diffusion soon)
- 🧩 Open interfaces for scripting or experimentation

Whether you're into LLMs, chat agents, image generation, or prompt engineering — this stack is built to grow with those needs.

---

## ✅ Features

- ✅ **Open WebUI** — A sleek, self-hosted chat interface
- ✅ **Ollama** — Local LLM runtime with support for models like `llama`, `mistral`, etc.
- ✅ **GPU support via NVIDIA Docker** (automatically enabled if available for Ollama, OpenWebUI, Jupyter, Pipelines)
- ✅ **Reverse proxy with Caddy** — Automatic HTTPS, SSL termination, service routing
- ✅ **Self-signed certificate generation at runtime via Caddy**
- ✅ **Isolated Docker network**
- ✅ **Environment-based config**
- ✅ **SearXNG integration** for RAG web search capabilities within Open WebUI
- ✅ **Jupyter Notebook integration** for code execution within Open WebUI
- ✅ **Pipelines service** for building AI workflows
- 🟡 **[Planned] Stable Diffusion container** for local image generation
- 🟡 **[Planned] Admin UI / service dashboard**

---

## 🚀 Getting Started

### 1. Clone the repo

```bash
git clone https://github.com/Taxel/aistack.git
cd aistack
```

### 2. Configure environment

Copy the example env file and adjust any values as needed:

```bash
cp .env.example .env
# Review and set JUPYTER_TOKEN and OPEN_WEBUI_SECRET_KEY if desired
```

### 3. Generate TLS certs (optional)

If no certificates exist, the Caddy container will generate self-signed certs at runtime automatically based on the `Caddyfile`.

### 4. Start the stack

```bash
docker compose up -d
```

> On first run, Ollama may download a model if you interact with one that isn't present locally. You also may have to download the model in the Open WebUI admin settings first. SearXNG also needs initial configuration.

### 5. Configure SearXNG for Open WebUI RAG

Edit `data/searxng/settings.yml` (it might be created on first run if not present) and ensure the `json` format is enabled under `search`:

```yaml
# data/searxng/settings.yml
search:
  # ... other settings ...
  formats:
    - html
    - json # Ensure this line is present and uncommented
    # - csv
    # - rss
# ... other settings ...
```
Restart the SearXNG container if you changed the file: `docker compose restart searxng`

### 6. Add hostnames to your system (not necessary for WSL2)

Edit `/etc/hosts` (Linux/macOS) or `C:\Windows\System32\drivers\etc\hosts` (Windows) and add the hostnames defined in `container/caddy/Caddyfile`:

```
127.0.0.1 openwebui.localhost
127.0.0.1 jupyter.localhost
```

Then visit:
🔗 **https://openwebui.localhost**
🔗 **https://jupyter.localhost** (Use the token from your `.env` file or the default `123456`)

Accept the self-signed cert warnings in your browser.

---

## ⚙️ GPU Support (Optional)

Make sure your host has:

- NVIDIA GPU + drivers
- [nvidia-container-toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html) installed

This is detected and enabled automatically in the `ollama`, `openwebui`, `jupyter`, and `pipelines` containers via the `runtime: nvidia` flag in `docker-compose.yml`.

Verify GPU access inside a container (e.g., Ollama):

```bash
docker exec -it ollama nvidia-smi
```

---

## 🛠️ Troubleshooting

- ❌ Can't access `openwebui.localhost` or `jupyter.localhost`? Make sure the domains are added to `/etc/hosts` (if not using WSL2) and the Caddy container is running (`docker ps`). Check Caddy logs: `docker logs caddy`.
- 🔐 SSL errors? The certs are self-signed by Caddy — accept the browser warning or import the root CA (`data/caddy/pki/authorities/local/root.crt`) into your browser/system keychain for development purposes.
- 🐳 No GPU? Services requiring GPU acceleration might run slower or fail. Ollama will fall back to CPU automatically.
- 🕸️ Web search not working in Open WebUI? Ensure SearXNG is running, configured correctly in `settings.yml` (Step 5), and Open WebUI environment variables for RAG are set in `docker-compose.yml`.
- 💻 Code execution not working in Open WebUI? Ensure Jupyter is running, accessible at `jupyter.localhost`, and Open WebUI environment variables for Code Interpreter are set in `docker-compose.yml`.
- ❓ No model in Open WebUI? That's normal on first launch. Go to Settings -> Admin -> Models and pull a model (e.g., `llama3`).

---

## 📈 Roadmap

- [ ] Stable Diffusion integration
- [ ] Web-based service monitor (optional)

---

## 🧠 Credits

- [Open WebUI](https://github.com/open-webui/open-webui)
- [Ollama](https://github.com/ollama/ollama)
- [Docker](https://www.docker.com/)
- [Caddy](https://caddyserver.com/)
- [SearXNG](https://github.com/searxng/searxng)
- [Jupyter](https://jupyter.org/)

---

## 🔓 License

MIT — use, remix, self-host freely.