# Agentic AI Setup for OpenClaw with OpenCode

Practical setup and debugging guides for OpenClaw + OpenCode, with deployment paths for DigitalOcean, Fly.io, Render, and Railway.

```text
  .-----------------------------------------------------------------------.
 /   ____                   _____ _	   _           _                  /|
/   / __ \                 / ____| |         /\   (_)         _|         / |
|  | |  | |_ __   ___ _ __| |    | | __ ___ /  \   _ _ __   _| |_  ___  /  |
|  | |  | | '_ \ / _ \ '_ \ |    | |/ _` \ / /\ \ | | '_ \ / _` | |/ _ \ |  |
|  | |__| | |_) |  __/ | | | |____| | (_| / ____ \| | | | | (_| | |  __/ |  |
|   \____/| .__/ \___|_| |_|\_____|_|\__,_/_/    \_\_|_| |_|\__,_|_|\___| |  |
|         | |                                                             |  |
|         |_|   Setup + Debug + Agent Training + PitStop Validation       |  |
|                                                                          |  |
|   [1] Install         [2] Configure         [3] Verify                  |  |
|   [4] Debug           [5] Train Agents      [6] Ship with confidence    |  |
|                                                                          |  |
|   > openclaw gateway status                                              |  |
|   > openclaw agent --agent main --message "Reply with OK" --json        |  |
|                                                                          |  |
|   Root docs: SETUP_AND_DEBUG_INDEX.md                                    |  |
|__________________________________________________________________________| /
 `--------------------------------------------------------------------------'
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
