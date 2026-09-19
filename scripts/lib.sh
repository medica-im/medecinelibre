#!/usr/bin/env bash
#
# Shared helpers: reading images.yml, and formatting output.
#
# images.yml is parsed with awk rather than yq. skcms needs yq because its
# entries nest and multiply; here there are two flat entries, and a release
# script that cannot run until a tool is installed is a release script that
# gets bypassed. Keep the file flat — "key: value" under "- name:" — and
# this stays correct.
set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
IMAGES_FILE="${IMAGES_FILE:-$REPO_ROOT/images.yml}"

if [[ -t 1 ]]; then
    BOLD=$'\033[1m'; DIM=$'\033[2m'; RED=$'\033[31m'
    YELLOW=$'\033[33m'; GREEN=$'\033[32m'; NC=$'\033[0m'
else
    BOLD=""; DIM=""; RED=""; YELLOW=""; GREEN=""; NC=""
fi

step() { printf '\n%s==> %s%s\n' "$BOLD" "$*" "$NC"; }
info() { printf '%s    %s%s\n' "$DIM" "$*" "$NC"; }
warn() { printf '%s    %s%s\n' "$YELLOW" "$*" "$NC" >&2; }
ok()   { printf '%s    %s%s\n' "$GREEN" "$*" "$NC"; }
die()  { printf '%serror: %s%s\n' "$RED" "$*" "$NC" >&2; exit 1; }

# image_names — every name in images.yml, one per line.
image_names() {
    awk '/^[[:space:]]*-[[:space:]]*name:/ {
        sub(/^[[:space:]]*-[[:space:]]*name:[[:space:]]*/, ""); print
    }' "$IMAGES_FILE"
}

# image_field <name> <field> — one value from that entry, empty if absent.
image_field() {
    local name="$1" field="$2"
    awk -v want="$name" -v key="$field" '
        /^[[:space:]]*-[[:space:]]*name:/ {
            line = $0
            sub(/^[[:space:]]*-[[:space:]]*name:[[:space:]]*/, "", line)
            inentry = (line == want)
            next
        }
        inentry && $0 ~ "^[[:space:]]+" key ":" {
            line = $0
            sub("^[[:space:]]+" key ":[[:space:]]*", "", line)
            sub(/[[:space:]]+#.*$/, "", line)          # trailing comment
            gsub(/^["'"'"']|["'"'"']$/, "", line)      # surrounding quotes
            print line
            exit
        }
    ' "$IMAGES_FILE"
}

# require_image <name> — resolve an entry or fail with the valid names.
require_image() {
    local name="$1"
    if ! image_names | grep -qxF "$name"; then
        printf '%serror: no image named %s in %s%s\n' \
            "$RED" "$name" "$IMAGES_FILE" "$NC" >&2
        printf 'available names:\n' >&2
        image_names | sed 's/^/  /' >&2
        exit 1
    fi
}
