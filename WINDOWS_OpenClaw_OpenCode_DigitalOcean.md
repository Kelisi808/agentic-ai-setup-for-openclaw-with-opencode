Aloha

# Fast setup on Windows: OpenCode + OpenClaw + DigitalOcean

This guide gets you from zero to a working OpenClaw server in about 20-40 minutes.

## 0) Prerequisites
- Windows 10/11
- Administrator PowerShell
- GitHub account
- DigitalOcean account
- Node.js LTS from https://nodejs.org

Verify installs:
```powershell
node -v
npm -v
git --version
```

## 1) Install OpenCode CLI
```powershell
npm install -g opencode-ai
opencode --version
```

## 2) Install OpenClaw CLI
```powershell
npm install -g openclaw
openclaw --version
```

## 3) Install DigitalOcean CLI (`doctl`)
```powershell
winget install DigitalOcean.doctl
doctl version
```

Authenticate:
```powershell
doctl auth init
```

## 4) Create SSH key for droplet access
```powershell
ssh-keygen -t ed25519 -C "openclaw-windows" -f $env:USERPROFILE\.ssh\openclaw_do_ed25519
Get-Content $env:USERPROFILE\.ssh\openclaw_do_ed25519.pub
```

Add public key in DigitalOcean:
- Settings -> Security -> SSH Keys -> Add SSH Key

## 5) Create a droplet with doctl
Find region/image options:
```powershell
doctl compute region list
doctl compute image list-distribution ubuntu --public
```

Create droplet (example):
```powershell
doctl compute droplet create pitstop-node --size s-1vcpu-1gb --image ubuntu-24-04-x64 --region nyc1 --ssh-keys "<YOUR_SSH_KEY_FINGERPRINT>" --wait
```

Get IP:
```powershell
doctl compute droplet list
```

## 6) Bootstrap server packages
Replace `<DROPLET_IP>`:
```powershell
ssh -i $env:USERPROFILE\.ssh\openclaw_do_ed25519 root@<DROPLET_IP> "apt update && apt upgrade -y && apt install -y git curl build-essential python3 python3-pip ufw"
```

Enable firewall:
```powershell
ssh -i $env:USERPROFILE\.ssh\openclaw_do_ed25519 root@<DROPLET_IP> "ufw allow OpenSSH && ufw allow http && ufw allow https && ufw --force enable && ufw status verbose"
```

## 7) Install Node + OpenClaw on droplet
```powershell
ssh -i $env:USERPROFILE\.ssh\openclaw_do_ed25519 root@<DROPLET_IP> "curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && apt install -y nodejs && npm install -g openclaw && openclaw --version"
```

## 8) Run OpenClaw onboarding (interactive)
```powershell
ssh -t -i $env:USERPROFILE\.ssh\openclaw_do_ed25519 root@<DROPLET_IP> "openclaw onboard"
```
During onboarding:
- Accept the security warning.
- Configure model auth (OpenAI API key or OpenAI Codex OAuth).
- Install gateway service.

## 9) Verify health
```powershell
ssh -i $env:USERPROFILE\.ssh\openclaw_do_ed25519 root@<DROPLET_IP> "openclaw gateway status && openclaw models status"
ssh -i $env:USERPROFILE\.ssh\openclaw_do_ed25519 root@<DROPLET_IP> "openclaw agent --agent main --message 'Reply with PITSTOP_READY only' --json"
ssh -i $env:USERPROFILE\.ssh\openclaw_do_ed25519 root@<DROPLET_IP> "systemctl status openclaw --no-pager"
```

## Optional
Install OpenCode on the droplet:
```powershell
ssh -i $env:USERPROFILE\.ssh\openclaw_do_ed25519 root@<DROPLET_IP> "npm install -g opencode-ai && opencode --version"
```

## Quick troubleshooting
- `Permission denied (publickey)`: wrong key path or key not added in DO.
- `No provider plugins found`: run and complete `openclaw onboard`.
- `No API key found`: run `openclaw configure` or onboard again.
- `gateway closed (1008): pairing required`: approve pairing in OpenClaw devices.

A Hui Hou
