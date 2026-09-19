#!/usr/bin/env bash
#
# Build, push and deploy one environment.
#
# Orchestration only: build-image.sh and deploy-image.sh do the work.
# The point of running them together is that the deploy happens only if
# the build succeeded — deploy-image.sh pulls a tag rather than building
# one, so deploying after a failed build would silently redeploy whatever
# that tag pointed at before, which looks like a successful release of
# stale code.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib.sh
source "$SCRIPT_DIR/lib.sh"

usage() {
    cat <<EOF
Usage: $(basename "$0") <name>

Builds, pushes and deploys <name> from images.yml.

  --build-only   build and push, do not deploy
  --dry-run      print what would happen, touch nothing
  --yes          skip the production confirmation prompt

Releasing production prompts for confirmation unless --yes is given.
EOF
}

NAME=""; BUILD_ONLY=0; DRY_RUN=0; ASSUME_YES=0
for arg in "$@"; do
    case "$arg" in
        -h|--help) usage; exit 0 ;;
        --list) image_names; exit 0 ;;
        --build-only) BUILD_ONLY=1 ;;
        --dry-run) DRY_RUN=1 ;;
        --yes|-y) ASSUME_YES=1 ;;
        -*) die "unknown option $arg" ;;
        *)
            [[ -n "$NAME" ]] && die "release one environment at a time"
            NAME="$arg" ;;
    esac
done
[[ -z "$NAME" ]] && { usage >&2; exit 1; }
require_image "$NAME"

cd "$REPO_ROOT"

# Releasing a dirty tree produces an image whose sha tag names a commit
# that does not contain what shipped. Allowed, but not silently.
if [[ -n "$(git status --porcelain)" ]]; then
    warn "working tree has uncommitted changes:"
    git status --short | sed 's/^/      /' >&2
fi

# Production is the live site; make the operator say so out loud.
if [[ "$NAME" == "production" && $ASSUME_YES -eq 0 && $DRY_RUN -eq 0 && $BUILD_ONLY -eq 0 ]]; then
    printf '\n%sAbout to release PRODUCTION (%s).%s\n' "$BOLD" "$(image_field "$NAME" url)" "$NC"
    printf 'Type %sproduction%s to continue: ' "$BOLD" "$NC"
    read -r reply
    [[ "$reply" == "production" ]] || die "aborted"
fi

DRY_FLAG=()
[[ $DRY_RUN -eq 1 ]] && DRY_FLAG=(--dry-run)

SECONDS=0
"$SCRIPT_DIR/build-image.sh" "$NAME" "${DRY_FLAG[@]}"

if [[ $BUILD_ONLY -eq 1 ]]; then
    ok "[$NAME] built and pushed; not deployed (--build-only)"
    exit 0
fi

"$SCRIPT_DIR/deploy-image.sh" "$NAME" "${DRY_FLAG[@]}"

ok "[$NAME] released in $((SECONDS / 60))m $((SECONDS % 60))s"
