#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
if ! command -v node >/dev/null || ! command -v npm >/dev/null; then
  if command -v apt-get >/dev/null; then sudo apt-get update && sudo apt-get install -y nodejs npm; else echo 'Install current Node.js LTS from https://nodejs.org/ then rerun.'; exit 1; fi
fi
node -e "const m=+process.versions.node.split('.')[0];if(m<20){console.error('Node.js 20+ required');process.exit(1)}"
npm install
npm run build:linux
echo 'Build complete: dist/'
