Aloha

# Security policy

Thank you for helping keep this project and its users safe.

## Supported scope
This repository contains setup guides and automation scripts for OpenCode + OpenClaw + DigitalOcean.
Security reports are welcome for:
- setup scripts in `windows/` and `mac/`
- documentation that could cause unsafe defaults
- accidental secret exposure in tracked files
- insecure cloud baseline recommendations

## Reporting a vulnerability
Please do not open public issues for active vulnerabilities.

Use private reporting through GitHub security advisories:
- Repository -> Security -> Advisories -> Report a vulnerability

If advisories are unavailable, open a minimal issue without exploit details and request a private contact path.

## What to include in your report
- Clear summary of the vulnerability
- Affected file/path and command sequence
- Reproduction steps
- Impact assessment
- Suggested fix (if available)

## Secrets and credentials policy
- Never commit API keys, tokens, private keys, or passphrases.
- If a secret is exposed, rotate it immediately and remove it from history if needed.
- Treat screenshots and logs as sensitive until reviewed.

## Secure usage baseline
- Use SSH keys (no password auth).
- Keep firewall limited to required ports (`22`, `80`, `443`).
- Store secrets in environment variables or a secrets manager.
- Review logs and audit actions regularly.

## Response goals
- Initial triage: within 72 hours
- Confirmed vulnerability fix target: as fast as practical based on severity
- Public disclosure: after fix is available

A Hui Hou
