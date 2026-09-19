#!/usr/bin/env bash
#
# Run the vite dev server.
#
# On the dev VPS this is what dev.medecinelibre.com serves, so it binds
# 0.0.0.0 rather than localhost — nginx proxies to it, and the point is to
# have the site live on a phone while editing, with no rebuild in the
# loop. Staging is where the built container gets tested; this is never
# that, and deliberately so.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib.sh
source "$SCRIPT_DIR/lib.sh"

usage() {
    cat <<EOF
Usage: $(basename "$0") [--port N] [--local]

Runs vite dev with the dev environment file.

  --port N   port to listen on (default: DEV_PORT from the env file, or 5173)
  --local    bind 127.0.0.1 only (default binds 0.0.0.0 for LAN/proxy access)
EOF
}

PORT=""; BIND_ALL=1
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help) usage; exit 0 ;;
        --port) PORT="${2:?--port needs a value}"; shift ;;
        --port=*) PORT="${1#--port=}" ;;
        --local) BIND_ALL=0 ;;
        *) die "unknown option $1" ;;
    esac
    shift
done

cd "$REPO_ROOT"

ENV_FILE=".env.dev.medecinelibre.com"
[[ -f "$ENV_FILE" ]] || die "$ENV_FILE not found. It is gitignored — see .env.example."

# vite reads .env from the project root and nothing else, so the dev file
# is linked into place. A symlink rather than a copy: editing the real
# file takes effect without remembering to re-copy, and `ls -l` shows
# which environment the tree is pointed at.
if [[ -L .env ]] || [[ ! -e .env ]]; then
    ln -sfn "$ENV_FILE" .env
elif ! cmp -s .env "$ENV_FILE"; then
    # A real file that differs: never clobber it silently — it may be the
    # only copy of a gitignored env.
    warn ".env is a regular file, not a symlink, and differs from $ENV_FILE."
    warn "Leaving it alone. Move it aside to let dev.sh manage .env:"
    warn "    mv .env .env.backup && ./scripts/dev.sh"
fi

[[ -z "$PORT" ]] && PORT="$(grep -E '^DEV_PORT=' "$ENV_FILE" 2>/dev/null | cut -d= -f2)"
PORT="${PORT:-5173}"

HOST_ARGS=(--host 0.0.0.0)
[[ $BIND_ALL -eq 0 ]] && HOST_ARGS=(--host 127.0.0.1)

step "vite dev  env=$ENV_FILE  port=$PORT  bind=${HOST_ARGS[1]}"
info "local:  http://localhost:$PORT"
[[ $BIND_ALL -eq 1 ]] && info "public: $(grep -E '^ORIGIN=' "$ENV_FILE" | cut -d= -f2-)"

exec pnpm exec vite dev --port "$PORT" --strictPort "${HOST_ARGS[@]}"
