#!/usr/bin/env bash
#
# Build static/images/og-default.jpg, the link-preview image (og:image) used
# by every page that does not set its own — what LinkedIn, Facebook, WhatsApp
# or Slack show when someone shares a medecinelibre.com URL.
#
# The blue gradient is the background of the prospection emails; the logo is
# rendered from LogoFull.svelte (plain SVG, painted white) so the image never
# drifts from the logo the site shows. 1200x630 is the size LinkedIn and
# Facebook expect.
#
# Needs only ffmpeg, built with librsvg and libfreetype (Debian's is).
#
#   ./scripts/og-image.sh
#   ./scripts/og-image.sh "Autre accroche" "sur deux lignes"
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib.sh
source "$SCRIPT_DIR/lib.sh"
cd "$REPO_ROOT"

LINE1="${1:-Sites et applications web}"
LINE2="${2:-pour MSP, CPTS et organisations de santé}"
FONT=static/fonts/Quicksand.ttf
BG=static/images/offres/email_msp_v2.jpg
OUT=static/images/og-default.jpg

command -v ffmpeg >/dev/null || die "ffmpeg not found"

TMP=$(mktemp -d); trap 'rm -rf "$TMP"' EXIT
printf '%s' "Médecine Libre" > "$TMP/name.txt"
printf '%s' "$LINE1" > "$TMP/l1.txt"
printf '%s' "$LINE2" > "$TMP/l2.txt"
printf '%s' "medecinelibre.com" > "$TMP/url.txt"

sed -e 's/class="fill-token"/fill="#ffffff"/' \
    -e 's/width="300px" height="300px"/width="166px" height="171px"/' \
    src/lib/components/Logos/LogoFull.svelte > "$TMP/logo.svg"
ffmpeg -hide_banner -loglevel error -y -i "$TMP/logo.svg" "$TMP/logo.png"

# Quicksand renders in its light weight; a 1-2px same-colour border thickens
# the strokes so the text stays legible when the card is shrunk to ~550px.
ffmpeg -hide_banner -loglevel error -y -i "$BG" -i "$TMP/logo.png" -filter_complex "\
[0]scale=-2:630,crop=1200:630[bg];\
[bg][1]overlay=x=(W-w)/2:y=42[b];\
[b]drawtext=fontfile=$FONT:textfile=$TMP/name.txt:fontsize=84:fontcolor=white:borderw=2:bordercolor=white:x=(w-text_w)/2:y=236,\
drawbox=x=(iw-140)/2:y=352:w=140:h=4:color=white@0.6:t=fill,\
drawtext=fontfile=$FONT:textfile=$TMP/l1.txt:fontsize=50:fontcolor=white:borderw=1:bordercolor=white:x=(w-text_w)/2:y=390,\
drawtext=fontfile=$FONT:textfile=$TMP/l2.txt:fontsize=42:fontcolor=white@0.9:borderw=1:bordercolor=white@0.9:x=(w-text_w)/2:y=458,\
drawtext=fontfile=$FONT:textfile=$TMP/url.txt:fontsize=30:fontcolor=white@0.75:x=(w-text_w)/2:y=560" \
    -frames:v 1 -q:v 2 "$OUT"

ok "wrote $OUT ($(( $(stat -c%s "$OUT") / 1024 )) KB)"
