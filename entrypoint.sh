#!/bin/bash
set -e

# ==================================================
# Auto-inicializa Homebrew no volume se necessário
# ==================================================
if [ ! -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
  echo "[entrypoint] Homebrew não encontrado no volume, inicializando..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || true
  echo "[entrypoint] Homebrew inicializado com sucesso!"
else
  echo "[entrypoint] Homebrew já está no volume, pulando instalação."
fi

# Garantir que o PATH do brew está disponível
export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:/home/node/.npm-global/bin:${PATH}"

# ==================================================
# Inicia o OpenClaw Gateway
# ==================================================
exec node dist/index.js gateway --bind lan --port 18789 --allow-unconfigured
