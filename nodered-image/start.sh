#!/usr/bin/env bash
set -euo pipefail

# Remove credenciais antigas para forçar re-leitura do flow e novos creds
rm -f /data/flows_cred.json || true

# Delegar para o entrypoint original da imagem Node-RED
exec /usr/src/node-red/docker-entrypoint.sh npm start --cache /data/.npm -- --userDir /data
