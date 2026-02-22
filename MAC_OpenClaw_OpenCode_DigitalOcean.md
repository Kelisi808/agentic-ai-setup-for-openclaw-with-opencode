Aloha

# Fast setup on macOS: OpenCode + OpenClaw + DigitalOcean

This guide gets you from zero to a working OpenClaw server quickly.

## 0) Prerequisites
- macOS
- Terminal
- Homebrew
- GitHub account
- DigitalOcean account

Install base tools:
```bash
brew update
brew install git node
```

Verify:
```bash
node -v
npm -v
git --version
```

## 1) Install OpenCode CLI
```bash
npm install -g opencode-ai
opencode --version
```

## 2) Install OpenClaw CLI
```bash
npm install -g openclaw
openclaw --version
```

## 3) Install DigitalOcean CLI (`doctl`)
```bash
brew install doctl
doctl version
```

Authenticate:
```bash
doctl auth init
```

## 4) Create SSH key for droplet access
```bash
ssh-keygen -t ed25519 -C "openclaw-mac" -f ~/.ssh/openclaw_do_ed25519
cat ~/.ssh/openclaw_do_ed25519.pub
```

Add key in DigitalOcean:
- Settings -> Security -> SSH Keys -> Add SSH Key

## 5) Create droplet with doctl
Find region/image options:
```bash
doctl compute region list
doctl compute image list-distribution ubuntu --public
```

Create droplet:
```bash
doctl compute droplet create pitstop-node \
  --size s-1vcpu-1gb \
  --image ubuntu-24-04-x64 \
  --region nyc1 \
  --ssh-keys "<YOUR_SSH_KEY_FINGERPRINT>" \
  --wait
```

Get IP:
```bash
doctl compute droplet list
```

## 6) Bootstrap server packages
Replace `<DROPLET_IP>`:
```bash
ssh -i ~/.ssh/openclaw_do_ed25519 root@<DROPLET_IP> "apt update && apt upgrade -y && apt install -y git curl build-essential python3 python3-pip ufw"
```

Enable firewall:
```bash
ssh -i ~/.ssh/openclaw_do_ed25519 root@<DROPLET_IP> "ufw allow OpenSSH && ufw allow http && ufw allow https && ufw --force enable && ufw status verbose"
```

## 7) Install Node + OpenClaw on droplet
```bash
ssh -i ~/.ssh/openclaw_do_ed25519 root@<DROPLET_IP> "curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && apt install -y nodejs && npm install -g openclaw && openclaw --version"
```

## 8) Run OpenClaw onboarding (interactive)
```bash
ssh -t -i ~/.ssh/openclaw_do_ed25519 root@<DROPLET_IP> "openclaw onboard"
```
Recommended:
- Accept security warning.
- Configure model auth (OpenAI API key or OpenAI Codex OAuth).
- Install/restart gateway service.

## 9) Verify health
```bash
ssh -i ~/.ssh/openclaw_do_ed25519 root@<DROPLET_IP> "openclaw gateway status && openclaw models status"
ssh -i ~/.ssh/openclaw_do_ed25519 root@<DROPLET_IP> "openclaw agent --agent main --message 'Reply with PITSTOP_READY only' --json"
ssh -i ~/.ssh/openclaw_do_ed25519 root@<DROPLET_IP> "systemctl status openclaw --no-pager"
```

## Optional
Install OpenCode on droplet:
```bash
ssh -i ~/.ssh/openclaw_do_ed25519 root@<DROPLET_IP> "npm install -g opencode-ai && opencode --version"
```

## Quick troubleshooting
- `Permission denied (publickey)`: wrong key or key not added in DO.
- `No provider plugins found`: complete `openclaw onboard` auth.
- `No API key found`: configure provider auth in onboarding/config.
- Pairing errors: approve pending device in `openclaw devices`.

A Hui Hou
