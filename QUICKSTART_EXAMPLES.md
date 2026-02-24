Aloha

# Pinned quickstart examples

These are copy and paste workflows for first-time users who want fast success.

## 1) Local CLI sanity check (2 minutes)

Windows PowerShell:
~~~powershell
npm install -g opencode-ai openclaw
opencode --version
openclaw --version
~~~

macOS Terminal:
~~~bash
npm install -g opencode-ai openclaw
opencode --version
openclaw --version
~~~

## 2) Pick one deployment target first

Read PITSTOP_DEPLOYMENT_OPTIONS.md and choose one platform for your first launch:
- DigitalOcean for full VPS control
- Fly.io for fast machine deployment
- Render for managed web service simplicity
- Railway for managed deployment workflow
- Railway referral (new users get $20 credit): https://railway.com?referralCode=BzQiz7

Use one canonical public URL at a time so users and agents are never confused.

## 3) If using DigitalOcean, create and secure a droplet

Use your platform guide first:
- WINDOWS_OpenClaw_OpenCode_DigitalOcean.md
- MAC_OpenClaw_OpenCode_DigitalOcean.md

Then run automation:
- Windows: windows/setup_openclaw_windows.ps1
- macOS: mac/setup_openclaw_mac.sh

## 4) OpenClaw onboarding and health checks

After SSH into your droplet or host, run:
~~~bash
openclaw onboard
openclaw gateway status
openclaw models status
openclaw agent --agent main --message "Reply with PITSTOP_READY only" --json
~~~

## 5) PitStop readiness smoke test

Use these checks to confirm your baseline before building milestones:
~~~bash
openclaw health --json
openclaw agent --agent coding-agent --message "Reply with OK only" --json
openclaw agent --agent main --session-id spawn-test --message "Use sessions_spawn with agentId coding-agent and task reply READY. Return exact tool JSON only." --json
~~~

## 6) Production-minded next steps

- Apply PITSTOP_OPTIMIZATION_CHECKLIST.md.
- Add monitoring, backups, and alerting.
- Keep secrets out of Git and rotate keys on a schedule.

A Hui Hou
