#!/usr/bin/env bash
#
# Pull a prebuilt image on its server and restart the container.
#
# Deliberately never builds: build-image.sh builds and pushes from your
# machine, this pulls that exact tag. Staging and production therefore run
# the same artefact you tested, not a rebuild that could drift.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib.sh
source "$SCRIPT_DIR/lib.sh"

usage() {
    cat <<EOF
Usage: $(basename "$0") <name>

Pulls the image described by <name> in images.yml on its host and restarts
the container. Never builds on the server.

  --list       print deployable names with host and dir
  --dry-run    print what would run, touch nothing
  --tag TAG    deploy this tag instead of the one in images.yml. Either a
               full reference or just the tag part, so the immutable tags
               build-image.sh pushes can be named directly:
                   --tag 47cb4d9
               This is the rollback path.
EOF
}

NAME=""; DRY_RUN=0; TAG_OVERRIDE=""; EXPECT_TAG=0
for arg in "$@"; do
    if [[ $EXPECT_TAG -eq 1 ]]; then TAG_OVERRIDE="$arg"; EXPECT_TAG=0; continue; fi
    case "$arg" in
        -h|--help) usage; exit 0 ;;
        --tag) EXPECT_TAG=1 ;;
        --tag=*) TAG_OVERRIDE="${arg#--tag=}" ;;
        --dry-run) DRY_RUN=1 ;;
        --list)
            printf '%-12s %-10s %s\n' NAME HOST DIR
            while read -r n; do
                printf '%-12s %-10s %s\n' "$n" "$(image_field "$n" host)" "$(image_field "$n" dir)"
            done < <(image_names)
            exit 0 ;;
        -*) die "unknown option $arg" ;;
        *)
            [[ -n "$NAME" ]] && die "deploy one image at a time (got '$NAME' and '$arg')"
            NAME="$arg" ;;
    esac
done
[[ $EXPECT_TAG -eq 1 ]] && die "--tag needs a value"
[[ -z "$NAME" ]] && { usage >&2; exit 1; }

require_image "$NAME"
HOST=$(image_field "$NAME" host)
DIR=$(image_field "$NAME" dir)
TAG=$(image_field "$NAME" tag)
COMPOSE_FILE=$(image_field "$NAME" compose_file)
URL=$(image_field "$NAME" url)

[[ -n "$HOST" && -n "$DIR" ]] || die "'$NAME' has no host/dir in images.yml — not deployable"

# A bare tag ("47cb4d9") is joined to this image's repository, so a
# rollback names only the tag read from the build output. A full reference
# is taken as given.
if [[ -n "$TAG_OVERRIDE" ]]; then
    if [[ "$TAG_OVERRIDE" == *:* ]]; then TAG="$TAG_OVERRIDE"
    else TAG="${TAG%:*}:$TAG_OVERRIDE"; fi
    info "tag overridden: $TAG"
fi

step "[$NAME] $TAG -> $HOST:$DIR ($COMPOSE_FILE)"

if [[ $DRY_RUN -eq 1 ]]; then
    info "(dry run) ssh $HOST: cd $DIR && docker compose -f $COMPOSE_FILE pull && up -d"
    exit 0
fi

ssh "$HOST" bash -s <<EOF
set -euo pipefail
cd "$DIR"

# DOCKER_IMAGE_NAME is what the compose files interpolate into image:.
# Exported rather than edited into .env so a rollback leaves no trace that
# the next ordinary deploy has to undo.
export DOCKER_IMAGE_NAME="$TAG"

echo "    pulling $TAG"
# --quiet: stdout is a pipe here, so Docker's progress bars degrade to one
# line per frame. Errors are still reported.
docker compose -f "$COMPOSE_FILE" pull --quiet

echo "    restarting"
docker compose -f "$COMPOSE_FILE" up -d --remove-orphans --quiet-pull

echo "    running:"
docker compose -f "$COMPOSE_FILE" ps --format '      {{.Service}}  {{.Status}}'

# Untagged layers from previous deploys add up on small servers.
docker image prune -f >/dev/null
EOF

if [[ -n "$URL" ]]; then
    step "[$NAME] checking $URL"
    # A deploy that restarts the container but serves a 502 is a failed
    # deploy; say so rather than reporting success.
    code=000
    for _ in 1 2 3 4 5 6 7 8 9 10; do
        code=$(curl -sS -o /dev/null -w '%{http_code}' --max-time 10 "$URL" 2>/dev/null || echo 000)
        if [[ "$code" == "200" ]]; then
            ok "[$NAME] $URL -> 200"
            exit 0
        fi
        sleep 3
    done
    warn "[$NAME] $URL did not return 200 (last: $code). Check the container."
    exit 1
fi
ok "[$NAME] done"
