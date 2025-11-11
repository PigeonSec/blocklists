#!/usr/bin/env bash
set -euo pipefail

# ── CONFIG ──────────────────────────────────────────────────────────────
REPO_DIR="/root/pigeonsec/blocklists"
ENV_FILE="$REPO_DIR/.env"

# ── LOAD ENV ───────────────────────────────────────────────────────────
if [ -f "$ENV_FILE" ]; then
  source "$ENV_FILE"
else
  echo "[!] ERROR: .env file not found at $ENV_FILE"
  exit 1
fi

if [ -z "${HC_BASE_URL:-}" ]; then
  echo "[!] ERROR: HC_BASE_URL not set in .env"
  exit 1
fi

# Remove trailing slash if any
HC_BASE_URL="${HC_BASE_URL%/}"

cd "$REPO_DIR"
start_ts=$(date +%s)
echo "[+] Magpie cron started at $(date -u)"

# ── HEALTHCHECK START ───────────────────────────────────────────────────
curl -fsS -m 10 --retry 3 "${HC_BASE_URL}/start" >/dev/null 2>&1 || echo "[!] Failed to ping start"

{
  # ── RUN MAGPIE ─────────────────────────────────────────────────────────
  ./magpie -s unclean/bad.txt -o bad.txt --silent
  ./magpie -s unclean/annoying.txt -o annoying.txt --silent

  # ── COMMIT & PUSH ─────────────────────────────────────────────────────
  git add bad.txt annoying.txt
  git commit -m "🪶 Auto-update via Magpie | $(date -u +"%Y-%m-%d %H:%M UTC")" >/dev/null 2>&1 || echo "No changes to commit."
  git push origin main >/dev/null 2>&1 || echo "[!] Git push failed"

  # ── HEALTHCHECK SUCCESS ───────────────────────────────────────────────
  curl -fsS -m 10 --retry 3 "${HC_BASE_URL}" >/dev/null 2>&1 || echo "[!] Failed to ping success"

  end_ts=$(date +%s)
  echo "[+] Magpie cron completed successfully in $((end_ts - start_ts))s"
} || {
  echo "[!] Magpie cron failed!"
  curl -fsS -m 10 --retry 3 "${HC_BASE_URL}/fail" >/dev/null 2>&1 || echo "[!] Failed to ping failure"
  exit 1
}
