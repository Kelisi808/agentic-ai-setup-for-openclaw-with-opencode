# Homework 2 Fast Setup (Windows)

This guide is designed to get students from zero to working OpenCode + OpenClaw + DigitalOcean in about 20-40 minutes.

## 0) Prerequisites
- Windows 10/11
- Admin PowerShell
- A GitHub account
- A DigitalOcean account
- Node.js LTS installed from https://nodejs.org

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

Optional D drive global install:
```powershell
npm install -g opencode-ai --prefix "D:\Opencode\npm-global"
setx PATH "D:\Opencode\npm-global;%PATH%"
```
Open a new terminal after `setx`.

## 2) Install OpenClaw CLI
```powershell
npm install -g openclaw
openclaw --version
```

## 3) Install DigitalOcean CLI (`doctl`)
```powershell
winget install DigitalOcean.doctl
```
Verify:
```powershell
doctl version
```

Authenticate:
```powershell
doctl auth init
```
(Use a personal access token from DigitalOcean.)

## 4) Create SSH key (for droplet access)
```powershell
ssh-keygen -t ed25519 -C "homework2-windows" -f $env:USERPROFILE\.ssh\homework2_do_ed25519
Get-Content $env:USERPROFILE\.ssh\homework2_do_ed25519.pub
```

Add that public key in DigitalOcean:
- Settings -> Security -> SSH Keys -> Add SSH Key

## 5) Create a droplet (automated with doctl)
Find IDs first:
```powershell
doctl compute region list
doctl compute image list-distribution ubuntu --public
```

Create droplet (example values):
```powershell
doctl compute droplet create pitstop-hw2 \
  --size s-1vcpu-1gb \
  --image ubuntu-24-04-x64 \
  --region nyc1 \
  --ssh-keys "<YOUR_SSH_KEY_FINGERPRINT>" \
  --wait
```

Get IP:
```powershell
doctl compute droplet list
```

## 6) First server bootstrap (copy/paste)
Replace `<DROPLET_IP>`:
```powershell
ssh -i $env:USERPROFILE\.ssh\homework2_do_ed25519 root@<DROPLET_IP> "apt update && apt upgrade -y && apt install -y git curl build-essential python3 python3-pip ufw"
```

Firewall:
```powershell
ssh -i $env:USERPROFILE\.ssh\homework2_do_ed25519 root@<DROPLET_IP> "ufw allow OpenSSH && ufw allow http && ufw allow https && ufw --force enable && ufw status verbose"
```

## 7) Install Node + OpenClaw on droplet
```powershell
ssh -i $env:USERPROFILE\.ssh\homework2_do_ed25519 root@<DROPLET_IP> "curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && apt install -y nodejs && npm install -g openclaw && openclaw --version"
```

## 8) Run OpenClaw onboarding (interactive)
```powershell
ssh -t -i $env:USERPROFILE\.ssh\homework2_do_ed25519 root@<DROPLET_IP> "openclaw onboard"
```
Recommended during onboarding:
- Accept risk statement
- Configure model auth (OpenAI API key or OpenAI Codex)
- Install gateway service
- Restart service when prompted

## 9) Verify OpenClaw health
```powershell
ssh -i $env:USERPROFILE\.ssh\homework2_do_ed25519 root@<DROPLET_IP> "openclaw gateway status && openclaw models status"
```

## 10) Homework 2 completion checks
Run these and include screenshot/output in submission:
```powershell
ssh -i $env:USERPROFILE\.ssh\homework2_do_ed25519 root@<DROPLET_IP> "openclaw agent --agent main --message 'Reply with HOMEWORK2_OK only' --json"
ssh -i $env:USERPROFILE\.ssh\homework2_do_ed25519 root@<DROPLET_IP> "systemctl status openclaw --no-pager"
```

## 11) (Optional) Install OpenCode on droplet too
```powershell
ssh -i $env:USERPROFILE\.ssh\homework2_do_ed25519 root@<DROPLET_IP> "npm install -g opencode-ai && opencode --version"
```

---

## Quick Troubleshooting
- `Permission denied (publickey)`: wrong SSH key path or key not added to DO.
- `No provider plugins found`: run `openclaw onboard` auth flow.
- `No API key found`: configure provider auth in onboarding or `openclaw configure`.
- `gateway closed (1008): pairing required`: approve device pairing via `openclaw devices` commands.
