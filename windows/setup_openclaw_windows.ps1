param(
  [string]$DropletName = "pitstop-node",
  [string]$Region = "nyc1",
  [string]$Size = "s-1vcpu-1gb",
  [string]$Image = "ubuntu-24-04-x64",
  [string]$SshKeyFingerprint,
  [string]$SshPrivateKey = "$env:USERPROFILE\.ssh\openclaw_do_ed25519"
)

$ErrorActionPreference = "Stop"

function Require-Command($cmd) {
  if (-not (Get-Command $cmd -ErrorAction SilentlyContinue)) {
    throw "Missing command: $cmd"
  }
}

Write-Host "[1/8] Checking required commands..."
Require-Command node
Require-Command npm
Require-Command git
Require-Command ssh
Require-Command doctl

Write-Host "[2/8] Installing CLIs (OpenCode/OpenClaw)..."
npm install -g opencode-ai openclaw | Out-Null

Write-Host "[3/8] Validating doctl auth..."
try { doctl account get | Out-Null } catch { throw "Run: doctl auth init" }

if (-not (Test-Path $SshPrivateKey)) {
  Write-Host "[4/8] Creating SSH key..."
  ssh-keygen -t ed25519 -C "openclaw-windows" -f $SshPrivateKey -N ""
  Write-Host "Public key (add to DigitalOcean):"
  Get-Content "$SshPrivateKey.pub"
  throw "Add key in DO then rerun with -SshKeyFingerprint"
}

if (-not $SshKeyFingerprint) {
  throw "Provide -SshKeyFingerprint from DigitalOcean SSH key list"
}

Write-Host "[5/8] Creating droplet..."
doctl compute droplet create $DropletName --size $Size --image $Image --region $Region --ssh-keys $SshKeyFingerprint --wait | Out-Null

Write-Host "[6/8] Resolving droplet IP..."
$ip = (doctl compute droplet list --format Name,PublicIPv4 --no-header | Where-Object { $_ -match "^$DropletName\s" } | ForEach-Object { ($_ -split "\s+")[1] })
if (-not $ip) { throw "Could not resolve droplet IP" }
Write-Host "Droplet IP: $ip"

Write-Host "[7/8] Bootstrapping server packages..."
ssh -i $SshPrivateKey root@$ip "apt update && apt upgrade -y && apt install -y git curl build-essential python3 python3-pip ufw"
ssh -i $SshPrivateKey root@$ip "ufw allow OpenSSH && ufw allow http && ufw allow https && ufw --force enable"
ssh -i $SshPrivateKey root@$ip "curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && apt install -y nodejs && npm install -g openclaw"

Write-Host "[8/8] Final checks..."
ssh -i $SshPrivateKey root@$ip "openclaw --version && openclaw gateway status || true"

Write-Host "Done. Next step (interactive):"
Write-Host "ssh -t -i $SshPrivateKey root@$ip \"openclaw onboard\""
