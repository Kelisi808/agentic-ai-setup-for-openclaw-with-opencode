#!/usr/bin/env bash
set -euo pipefail

DROPLET_NAME="${DROPLET_NAME:-pitstop-node}"
REGION="${REGION:-nyc1}"
SIZE="${SIZE:-s-1vcpu-1gb}"
IMAGE="${IMAGE:-ubuntu-24-04-x64}"
SSH_KEY_PATH="${SSH_KEY_PATH:-$HOME/.ssh/openclaw_do_ed25519}"
SSH_KEY_FP="${SSH_KEY_FP:-}"

need() { command -v "$1" >/dev/null 2>&1 || { echo "Missing command: $1"; exit 1; }; }

echo "[1/8] Checking required commands..."
need brew
need node
need npm
need git
need ssh
need doctl

echo "[2/8] Installing CLIs (OpenCode/OpenClaw)..."
npm install -g opencode-ai openclaw >/dev/null

echo "[3/8] Validating doctl auth..."
doctl account get >/dev/null || { echo "Run: doctl auth init"; exit 1; }

if [[ ! -f "$SSH_KEY_PATH" ]]; then
  echo "[4/8] Creating SSH key..."
  ssh-keygen -t ed25519 -C "openclaw-mac" -f "$SSH_KEY_PATH" -N ""
  echo "Add this key to DigitalOcean:" && cat "$SSH_KEY_PATH.pub"
  echo "Then rerun with: SSH_KEY_FP=<fingerprint> ./setup_openclaw_mac.sh"
  exit 1
fi

[[ -n "$SSH_KEY_FP" ]] || { echo "Set SSH_KEY_FP to your DO key fingerprint"; exit 1; }

echo "[5/8] Creating droplet..."
doctl compute droplet create "$DROPLET_NAME" \
  --size "$SIZE" \
  --image "$IMAGE" \
  --region "$REGION" \
  --ssh-keys "$SSH_KEY_FP" \
  --wait >/dev/null

echo "[6/8] Resolving droplet IP..."
IP="$(doctl compute droplet list --format Name,PublicIPv4 --no-header | awk -v n="$DROPLET_NAME" '$1==n {print $2}')"
[[ -n "$IP" ]] || { echo "Could not resolve droplet IP"; exit 1; }
echo "Droplet IP: $IP"

echo "[7/8] Bootstrapping server packages..."
ssh -i "$SSH_KEY_PATH" root@"$IP" "apt update && apt upgrade -y && apt install -y git curl build-essential python3 python3-pip ufw"
ssh -i "$SSH_KEY_PATH" root@"$IP" "ufw allow OpenSSH && ufw allow http && ufw allow https && ufw --force enable"
ssh -i "$SSH_KEY_PATH" root@"$IP" "curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && apt install -y nodejs && npm install -g openclaw"

echo "[8/8] Final checks..."
ssh -i "$SSH_KEY_PATH" root@"$IP" "openclaw --version && openclaw gateway status || true"

echo "Done. Next (interactive):"
echo "ssh -t -i $SSH_KEY_PATH root@$IP 'openclaw onboard'"
