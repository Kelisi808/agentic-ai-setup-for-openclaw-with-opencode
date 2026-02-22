# Beginner Troubleshooting + FAQ (OpenCode/OpenClaw/DigitalOcean)

This guide is for students who are brand new to coding, CLI, and cloud setup.

## Start Here (If You Are New)
- **CLI** = Command Line Interface (Terminal/PowerShell where you type commands)
- **IDE** = code editor app (VS Code is most common)
- **Repository (repo)** = project folder tracked by GitHub
- **Droplet** = a cloud Linux server in DigitalOcean

If you can copy/paste commands and read error messages, you can complete this setup.

## What You Install (and Why)
1. **Git**: download/clone projects from GitHub.
2. **Node.js + npm**: required to install OpenCode/OpenClaw CLIs.
3. **OpenCode**: coding assistant CLI.
4. **OpenClaw**: agent platform CLI/gateway.
5. **doctl**: DigitalOcean CLI for droplet creation.
6. **SSH key**: secure login to your droplet.

## Zero-to-Working Checklist
1. Install tools (`git`, `node`, `npm`, `openclaw`, `opencode`, `doctl`).
2. Authenticate `doctl` with a DigitalOcean token.
3. Create SSH key and add the **public key** in DigitalOcean.
4. Create droplet.
5. SSH into droplet.
6. Install OpenClaw on droplet and run `openclaw onboard`.
7. Verify with health/status commands.

---

## Installation Help (Windows)
### Recommended
- Install **Git for Windows**
- Install **Node.js LTS** from nodejs.org
- Install **doctl** with:
```powershell
winget install DigitalOcean.doctl
```
- Install CLIs:
```powershell
npm install -g opencode-ai openclaw
```

### Verify
```powershell
git --version
node -v
npm -v
openclaw --version
opencode --version
doctl version
```

## Installation Help (macOS)
### Recommended
- Install Homebrew
- Install tools:
```bash
brew update
brew install git node doctl
npm install -g opencode-ai openclaw
```

### Verify
```bash
git --version
node -v
npm -v
openclaw --version
opencode --version
doctl version
```

---

## Most Common Errors + Fixes

### 1) `command not found`
**Cause:** tool not installed or terminal not reloaded.
**Fix:** install tool, close/reopen terminal, run version command again.

### 2) `Permission denied (publickey)` when SSH
**Cause:** wrong private key OR public key not added to DigitalOcean.
**Fix:**
- confirm private key path is correct
- add matching `.pub` key in DO -> Settings -> Security -> SSH Keys
- retry SSH with explicit `-i <key_path>`

### 3) SSH timeout
**Cause:** wrong IP, droplet not running, network/firewall delay.
**Fix:**
- verify droplet status in DO dashboard
- confirm IP with `doctl compute droplet list`
- wait 1-2 min after droplet creation and retry

### 4) `No provider plugins found`
**Cause:** auth not completed through onboarding flow.
**Fix:** run `openclaw onboard` and finish interactive auth.

### 5) `No API key found for provider ...`
**Cause:** model provider auth missing.
**Fix:**
- run `openclaw onboard` or `openclaw configure`
- verify with `openclaw models status`

### 6) `gateway closed ... pairing required`
**Cause:** pending device pairing.
**Fix:** approve pending device in OpenClaw device workflow and retry.

### 7) `Repository not found` on git push
**Cause:** repo not created yet on GitHub or wrong remote URL.
**Fix:**
- create repo in GitHub first
- check `git remote -v`
- use `git@github.com:<username>/<repo>.git`

---

## How to Find API Keys (OpenAI, Claude, Gemini, Grok + OpenRouter)
Use this section when onboarding asks for provider authentication.

### OpenAI
- Go to: https://platform.openai.com/
- Sign in -> open API keys page -> create a new secret key.
- Save it immediately (you may not be able to view full key again).

### Claude (Anthropic)
- Go to: https://console.anthropic.com/
- Sign in -> API Keys -> create key.
- Copy and store in your password manager.

### Gemini (Google AI)
- Go to: https://aistudio.google.com/
- Sign in -> Get API key / API keys -> create key.
- Ensure the correct Google account/project is selected.

### Grok (xAI)
- Go to: https://console.x.ai/
- Sign in -> API / Keys section -> create key.
- Copy the key and keep it private.

### OpenRouter (popular alternative)
- Go to: https://openrouter.ai/
- Sign in -> Keys -> create key.
- Useful if course workflows mention OpenRouter-supported models.

Security reminders:
- Never post API keys in Canvas, GitHub, or screenshots.
- Never commit keys into `.env` files that are pushed to GitHub.
- Revoke and regenerate any key you accidentally expose.

---

## Verification Commands (Submission Readiness)
Run these and keep output screenshots:
```bash
openclaw gateway status
openclaw models status
openclaw agent --agent main --message "Reply with HOMEWORK2_OK only" --json
```
On droplet:
```bash
systemctl status openclaw --no-pager
```

---

## FAQ (Beginner Friendly)

### Q1) Do I need to know coding first?
No. You mainly need to run commands carefully and follow steps in order.

### Q2) What is the difference between local machine and droplet?
- Local = your laptop/desktop.
- Droplet = cloud server that can keep running even when your laptop is off.

### Q3) Why do we use SSH keys instead of password?
SSH keys are more secure and are the standard for server access.

### Q4) Why do I still need an interactive step?
Provider auth (like OAuth) requires your account login/approval and cannot be fully automated safely.

### Q5) Can I use only GUI and avoid CLI?
Not for this assignment. You need basic CLI commands for setup and verification.

### Q6) Is this setup destructive?
It creates cloud resources (droplet) and may incur small costs in DigitalOcean.
Delete unused droplets when done.

### Q7) Do I need OpenCode and OpenClaw both?
For this class workflow: yes, install both so you can follow all exercises.

