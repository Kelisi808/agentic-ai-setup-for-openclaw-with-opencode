# Agentic AI Setup for OpenClaw with OpenCode

Practical setup and debugging guides for OpenClaw + OpenCode, with deployment paths for DigitalOcean, Fly.io, Render, and Railway.

```text
+==========================================================================+
|                                                                          |
|  _   _                 _          _                                      |
| | | | | _____      __ | |_ ___   / \      ___  ___ _   _ _ __           |
| | |_| |/ _ \ \ /\ / / | __/ _ \ / _ \    / __|/ _ \ | | | '_ \          |
| |  _  | (_) \ V  V /  | || (_) / ___ \   \__ \  __/ |_| | |_) |         |
| |_| |_|\___/ \_/\_/    \__\___/_/   \_\  |___/\___|\__,_| .__/          |
|                                                          |_|             |
|                                                                          |
|   ____                      ____ _                                       |
|  / __ \                    / ___| |                                      |
| | |  | |_ __   ___ _ __   | |   | | __ ___      __                       |
| | |  | | '_ \ / _ \ '_ \  | |   | |/ _` \ \ /\ / /                       |
| | |__| | |_) |  __/ | | | | |___| | (_| |\ V  V /                        |
|  \____/| .__/ \___|_| |_|  \____|_|\__,_| \_/\_/                         |
|        |_|                                                               |
|                                                                          |
|  Setup -> Configure -> Verify -> Debug -> Train -> Deploy               |
|  Start here: SETUP_AND_DEBUG_INDEX.md                                   |
|                                                                          |
+==========================================================================+
```

## What this repository is for
- Getting OpenClaw running quickly with copy/paste steps.
- Debugging common failures (auth, gateway, model, process, delivery).
- Building and validating real agent workflows for PitStop.

## Start here
1. `SETUP_AND_DEBUG_INDEX.md` (best entry point)
2. `QUICKSTART_EXAMPLES.md` (fastest path to first success)
3. Your platform guide:
   - `WINDOWS_OpenClaw_OpenCode_DigitalOcean.md`
   - `MAC_OpenClaw_OpenCode_DigitalOcean.md`

## Core docs
- `AI_AGENTS_WITH_OPENCLAW_OPENCODE_DIGITALOCEAN.md`
- `BEGINNER_TROUBLESHOOTING_FAQ.md`
- `PITSTOP_DEPLOYMENT_OPTIONS.md`
- `PITSTOP_OPTIMIZATION_CHECKLIST.md`

## Automation scripts
- `windows/setup_openclaw_windows.ps1`
- `mac/setup_openclaw_mac.sh`

## OpenClaw upstream links
- OpenClaw GitHub: https://github.com/openclaw/openclaw
- OpenClaw Docs: https://docs.openclaw.ai
- OpenClaw npm: https://www.npmjs.com/package/openclaw

## Optional upstream remote
```bash
git remote add upstream https://github.com/openclaw/openclaw.git
git remote -v
```
