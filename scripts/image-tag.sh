#!/usr/bin/env bash
#
# Print the immutable tag for a build: this repository's short sha, plus
# "-dirty" when the tree has uncommitted changes.
#
#   47cb4d9
#   47cb4d9-dirty
#
# Why this exists: build_push_production.sh pushed :production alone, so
# every push moved that one pointer and the image it displaced became
# unaddressable. A bad deploy had nothing to roll back to even when the
# commit it came from was known — a label records what an image is, but
# only a tag can ask a registry for it.
#
# Overridable for testing: IMAGE_TAG_GIT_SHA, IMAGE_TAG_DIRTY (0|1).
set -euo pipefail

GIT_SHA="${IMAGE_TAG_GIT_SHA:-$(git rev-parse HEAD)}"

if [[ -n "${IMAGE_TAG_DIRTY:-}" ]]; then
    DIRTY="$IMAGE_TAG_DIRTY"
else
    DIRTY=0
    [[ -n "$(git status --porcelain 2>/dev/null)" ]] && DIRTY=1
fi

TAG="${GIT_SHA:0:7}"
[[ "$DIRTY" == "1" ]] && TAG="${TAG}-dirty"
printf '%s\n' "$TAG"
