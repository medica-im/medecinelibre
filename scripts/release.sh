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

Releasing production prompts for confirmation unless --yes is given, and
fast-forwards main to the commit being released (see below).
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
# that does not contain what shipped. Allowed for staging, but not silently.
DIRTY=0
if [[ -n "$(git status --porcelain)" ]]; then
    DIRTY=1
    warn "working tree has uncommitted changes:"
    git status --short | sed 's/^/      /' >&2
fi

# Production ships main. Work happens on short-lived branches, so releasing
# production from a branch fast-forwards main to it and pushes main — the
# merge that would otherwise be done by hand, and forgotten.
#
# - Fast-forward only: if main has commits this branch lacks, stop rather
#   than merge; that needs a human.
# - No checkout: `git fetch . HEAD:main` moves the main ref in place, so the
#   working tree (which the dev server serves) never switches branch.
# - main moves only after the image has built, so a failed build leaves it
#   untouched.
# - Production refuses a dirty tree: the image must match a commit on main.
PROMOTE=0
if [[ "$NAME" == "production" ]]; then
    [[ $DIRTY -eq 1 ]] && die "commit or stash your changes first: production must ship a commit that main can point to."
    git fetch --quiet origin main || die "could not fetch origin/main"
    HEAD_SHA=$(git rev-parse HEAD)
    MAIN_SHA=$(git rev-parse origin/main)
    if [[ "$HEAD_SHA" != "$MAIN_SHA" ]]; then
        git merge-base --is-ancestor "$MAIN_SHA" "$HEAD_SHA" \
            || die "origin/main has commits that $(git rev-parse --abbrev-ref HEAD) lacks. Merge or rebase onto main first."
        PROMOTE=1
        PROMOTE_MSG="main ${MAIN_SHA:0:7} -> ${HEAD_SHA:0:7} ($(git rev-list --count "$MAIN_SHA..$HEAD_SHA") commits from $(git rev-parse --abbrev-ref HEAD))"
    fi
fi

# Production is the live site; make the operator say so out loud.
if [[ "$NAME" == "production" && $ASSUME_YES -eq 0 && $DRY_RUN -eq 0 && $BUILD_ONLY -eq 0 ]]; then
    printf '\n%sAbout to release PRODUCTION (%s).%s\n' "$BOLD" "$(image_field "$NAME" url)" "$NC"
    [[ $PROMOTE -eq 1 ]] && printf 'This will fast-forward and push %s.\n' "$PROMOTE_MSG"
    printf 'Type %sproduction%s to continue: ' "$BOLD" "$NC"
    read -r reply
    [[ "$reply" == "production" ]] || die "aborted"
fi

DRY_FLAG=()
[[ $DRY_RUN -eq 1 ]] && DRY_FLAG=(--dry-run)

SECONDS=0
"$SCRIPT_DIR/build-image.sh" "$NAME" "${DRY_FLAG[@]}"

if [[ $PROMOTE -eq 1 ]]; then
    step "[$NAME] promote: $PROMOTE_MSG"
    if [[ $DRY_RUN -eq 1 ]]; then
        info "(dry run) git fetch . HEAD:main && git push origin HEAD:main"
    else
        # On main already, the local ref is HEAD; otherwise move it in place.
        [[ "$(git rev-parse --abbrev-ref HEAD)" == "main" ]] || git fetch --quiet . HEAD:main
        git push --quiet origin HEAD:main
        ok "[$NAME] main is now ${HEAD_SHA:0:7}"
    fi
fi

if [[ $BUILD_ONLY -eq 1 ]]; then
    ok "[$NAME] built and pushed; not deployed (--build-only)"
    exit 0
fi

"$SCRIPT_DIR/deploy-image.sh" "$NAME" "${DRY_FLAG[@]}"

ok "[$NAME] released in $((SECONDS / 60))m $((SECONDS % 60))s"
