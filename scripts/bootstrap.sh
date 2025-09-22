#!/bin/bash
set -euo pipefail

# Point Git at the tracked hooks directory
git config core.hooksPath .githooks

# Ensure uv is available
if ! command -v uv >/dev/null 2>&1; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
  export PATH="$HOME/.local/bin:$PATH"
fi

# Sync dev deps
uv sync --dev --directory ./neurotechx-website
uvx pre-commit run --all-files || true

echo "✅ Hooks installed and ready to go!"
