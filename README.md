# 🧠 aistack

A local, self-hosted AI stack featuring Open WebUI, Ollama, and (soon) Stable Diffusion. Designed for privacy, extensibility, and full control over how you interact with powerful language and image models — all without relying on cloud APIs or third-party services.

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
- ✅ **GPU support via NVIDIA Docker** (automatically enabled if available)  
- ✅ **Reverse proxy with Nginx** — SSL termination, service routing  
- ✅ **Self-signed certificate generation at runtime**  
- ✅ **Isolated Docker network**  
- ✅ **Environment-based config**  
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
```

### 3. Generate TLS certs (optional)

If no certificates exist, the Nginx container will generate self-signed certs at runtime automatically.

### 4. Start the stack

```bash
docker compose up -d
```

> On first run, Ollama may download a model if you interact with one that isn't present locally. You also may have to download the model in the admin settings first.

### 5. Edit `data/searxng/settings.ini` and add the following:
```
search:
  # remove format to deny access, use lower case.
  # formats: [html, csv, json, rss]
  formats:
    - html
    - json
```
(add the `json`)

### 6. Add hostnames to your system (not necessary for WSL2)

Edit `/etc/hosts` (Linux/macOS) or `C:\Windows\System32\drivers\etc\hosts` (Windows) and add:

```
127.0.0.1 openwebui.localhost
```

Then visit:  
🔗 **https://openwebui.localhost**  
Accept the self-signed cert in your browser.

---

## ⚙️ GPU Support (Optional)

Make sure your host has:

- NVIDIA GPU + drivers  
- [nvidia-container-toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html) installed  

This is detected and enabled automatically in the `ollama` container via the `runtime: nvidia` flag.

Verify GPU access:

```bash
docker exec -it ollama nvidia-smi
```

---


## 🛠️ Troubleshooting

- ❌ Can't access `openwebui.localhost`? Make sure the domain is added to `/etc/hosts` and Nginx is running.  
- 🔐 SSL errors? The cert is self-signed — accept the browser warning or import it as a trusted root cert for dev use.  
- 🐳 No GPU? Ollama will fall back to CPU automatically.  
- No model in Open Webui? That's normal. You need to download the model in the administrator settings.

---

## 📈 Roadmap

- [ ] Stable Diffusion integration  
- [ ] Jupyter Notebook integration
- [ ] searxng for local web search
- [ ] Web-based service monitor (optional)  

---

## 🧠 Credits

- [Open WebUI](https://github.com/open-webui/open-webui)  
- [Ollama](https://github.com/ollama/ollama)  
- [Docker](https://www.docker.com/)  
- [Nginx](https://nginx.org/)  

---

## 🔓 License

MIT — use, remix, self-host freely.