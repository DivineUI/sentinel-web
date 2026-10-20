#!/usr/bin/env bash
# Install GitHub CLI (gh) inside WSL -- used by Operation Sentinel Web Phase 3.
set -euo pipefail

apt-get update -qq
apt-get install -y -qq gh

echo "gh installed:"
gh --version
