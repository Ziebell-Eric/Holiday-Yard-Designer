#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
if ! command -v node >/dev/null || ! command -v npm >/dev/null; then
  if command -v brew >/dev/null; then brew install node; else echo 'Install Node.js LTS from https://nodejs.org/ then rerun.'; exit 1; fi
fi
npm install
npm run build:mac
echo 'Build complete: dist/'
