#!/usr/bin/env bash
#
# Build and push the image described by <name> in images.yml.
#
# Pushes two tags: the moving one from images.yml (:production, :staging)
# and an immutable one from the commit sha. The immutable tag is the
# rollback path — see scripts/image-tag.sh.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib.sh
source "$SCRIPT_DIR/lib.sh"

usage() {
    cat <<EOF
Usage: $(basename "$0") <name>
       $(basename "$0") --list

Builds and pushes the image described by <name> in images.yml.

  --list       print available image names
  --no-push    build only, do not push
  --dry-run    print the docker command, build nothing
EOF
}

NAME=""; NO_PUSH=0; DRY_RUN=0
for arg in "$@"; do
    case "$arg" in
        -h|--help) usage; exit 0 ;;
        --list) image_names; exit 0 ;;
        --no-push) NO_PUSH=1 ;;
        --dry-run) DRY_RUN=1 ;;
        -*) die "unknown option $arg" ;;
        *)
            [[ -n "$NAME" ]] && die "build one image at a time (got '$NAME' and '$arg')"
            NAME="$arg" ;;
    esac
done
[[ -z "$NAME" ]] && { usage >&2; exit 1; }

require_image "$NAME"
TARGET=$(image_field "$NAME" target)
ENV_FILE=$(image_field "$NAME" env_file)
TAG=$(image_field "$NAME" tag)

cd "$REPO_ROOT"

# .env* is gitignored, so a fresh clone has none of these. Checked here
# rather than letting docker fail deep in the build with a less obvious
# message.
[[ -f "$ENV_FILE" ]] || die "$ENV_FILE not found. It is gitignored — copy it from another machine (see .env.example)."

GIT_SHA=$(git rev-parse HEAD)
IMMUTABLE_TAG="${TAG%:*}:$("$SCRIPT_DIR/image-tag.sh")"

case "$IMMUTABLE_TAG" in
    *-dirty)
        warn "building with uncommitted changes."
        warn "$IMMUTABLE_TAG names a commit that does not contain what is in this image." ;;
esac

step "[$NAME] build  target=$TARGET  env=$ENV_FILE"
info "tags: $TAG"
info "      $IMMUTABLE_TAG"

if [[ $DRY_RUN -eq 1 ]]; then
    info "(dry run) docker build --target $TARGET --build-arg ENV_FILE=$ENV_FILE -t $TAG -t $IMMUTABLE_TAG ."
    exit 0
fi

docker build \
    --target "$TARGET" \
    --build-arg ENV_FILE="$ENV_FILE" \
    --build-arg GIT_SHA="$GIT_SHA" \
    -t "$TAG" \
    -t "$IMMUTABLE_TAG" \
    .

if [[ $NO_PUSH -eq 1 ]]; then
    ok "[$NAME] built (not pushed): $TAG"
    exit 0
fi

step "[$NAME] push"
docker push "$TAG"
docker push "$IMMUTABLE_TAG"
ok "[$NAME] done: $TAG ($IMMUTABLE_TAG)"
