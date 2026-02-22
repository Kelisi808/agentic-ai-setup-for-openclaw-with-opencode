Aloha

# Beginner troubleshooting and FAQ (OpenCode/OpenClaw/DigitalOcean)

This guide is for anyone new to coding, CLI tools, and cloud setup.

## Start here
- **CLI** = command line (Terminal/PowerShell where you type commands).
- **IDE** = code editor app (VS Code is common).
- **Repository** = project folder tracked in Git.
- **Droplet** = a cloud Linux server in DigitalOcean.

If you can copy commands and read errors, you can complete this setup.

## What you install (and why)
1. **Git**: clone and version your project.
2. **Node.js + npm**: install OpenCode and OpenClaw CLIs.
3. **OpenCode**: coding assistant CLI.
4. **OpenClaw**: agent runtime and gateway.
5. **doctl**: DigitalOcean CLI.
6. **SSH key**: secure server login.

## Zero-to-working checklist
1. Install tools (`git`, `node`, `npm`, `openclaw`, `opencode`, `doctl`).
2. Authenticate `doctl` with your DigitalOcean token.
3. Create SSH key and add the public key in DigitalOcean.
4. Create droplet.
5. SSH into droplet.
6. Install OpenClaw and run `openclaw onboard`.
7. Verify with health commands.

## Common errors and fixes
### `command not found`
- Cause: tool not installed or terminal not reloaded.
- Fix: install tool and reopen terminal.

### `Permission denied (publickey)`
- Cause: wrong private key or key not added to DO.
- Fix: verify key path and add matching `.pub` key in DO.

### SSH timeout
- Cause: wrong IP, droplet booting, firewall delay.
- Fix: confirm with `doctl compute droplet list` and retry in 1-2 minutes.

### `No provider plugins found`
- Cause: provider auth not completed.
- Fix: run `openclaw onboard` and finish interactive auth.

### `No API key found for provider ...`
- Cause: model provider auth missing.
- Fix: run `openclaw configure` or onboarding again.

### `gateway closed ... pairing required`
- Cause: pending device pairing.
- Fix: approve the device in OpenClaw and retry.

### `Repository not found` on `git push`
- Cause: wrong remote URL or repo does not exist.
- Fix: check `git remote -v` and create/fix remote URL.

## Where to find API keys
### OpenAI
- https://platform.openai.com/ -> API keys -> create key.

### Claude (Anthropic)
- https://console.anthropic.com/ -> API Keys.

### Gemini (Google)
- https://aistudio.google.com/ -> create API key.

### Grok (xAI)
- https://console.x.ai/ -> API keys.

### OpenRouter
- https://openrouter.ai/ -> Keys.

Security reminders:
- Never commit API keys.
- Never post API keys in screenshots.
- Revoke and rotate exposed keys immediately.

## Verification commands
```bash
openclaw gateway status
openclaw models status
openclaw agent --agent main --message "Reply with PITSTOP_READY only" --json
```
On droplet:
```bash
systemctl status openclaw --no-pager
```

## FAQ
### Do I need coding experience?
No. You need basic command-line comfort and careful copy/paste.

### Why SSH keys over passwords?
SSH keys are stronger and the standard for server access.

### Why is onboarding interactive?
OAuth/API auth and security confirmations require manual approval.

### Is there a cost?
Yes. DigitalOcean resources can incur charges while running.

### Do I need OpenCode and OpenClaw both?
Yes, for this repository workflow.

A Hui Hou
