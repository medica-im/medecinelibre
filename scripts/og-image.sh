#!/usr/bin/env bash
#
# Build the link-preview images (og:image) used by every page that does not
# set its own — what apps show when someone shares a medecinelibre.com URL.
#
#   static/images/og-default.jpg   logo, name, tagline and URL. For previews
#                                  shown large: Facebook, WhatsApp, Slack,
#                                  email clients.
#   static/images/og-linkedin.jpg  logo and name only, as large as they fit.
#                                  LinkedIn has shown organic link posts as a
#                                  ~160x84 thumbnail since 2024, where the
#                                  tagline turns to mush. The server serves
#                                  this one to LinkedInBot only (see
#                                  src/hooks.server.ts).
#
# The blue gradient is the background of the prospection emails; the logo is
# rendered from LogoFull.svelte (plain SVG, painted white) so the images never
# drift from the logo the site shows. Both are 1200x630.
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
DEFAULT=static/images/og-default.jpg
LINKEDIN=static/images/og-linkedin.jpg

command -v ffmpeg >/dev/null || die "ffmpeg not found"

TMP=$(mktemp -d); trap 'rm -rf "$TMP"' EXIT
printf '%s' "Médecine Libre" > "$TMP/name.txt"
printf '%s' "Médecine" > "$TMP/name1.txt"
printf '%s' "Libre" > "$TMP/name2.txt"
printf '%s' "$LINE1" > "$TMP/l1.txt"
printf '%s' "$LINE2" > "$TMP/l2.txt"
printf '%s' "medecinelibre.com" > "$TMP/url.txt"

# logo <width> <height> <out.png>: LogoFull.svelte rendered white.
logo() {
    sed -e 's/class="fill-token"/fill="#ffffff"/' \
        -e "s/width=\"300px\" height=\"300px\"/width=\"$1px\" height=\"$2px\"/" \
        src/lib/components/Logos/LogoFull.svelte > "$TMP/logo.svg"
    ffmpeg -hide_banner -loglevel error -y -i "$TMP/logo.svg" "$3"
}

# text_width <textfile> <fontsize> <border>: rendered width in px, measured
# rather than guessed so the LinkedIn layout can be centred exactly.
text_width() {
    ffmpeg -hide_banner -f lavfi -i color=c=black:s=1600x300 \
        -vf "drawtext=fontfile=$FONT:textfile=$1:fontsize=$2:borderw=$3:fontcolor=white:x=0:y=0,cropdetect=limit=0.1:round=2" \
        -frames:v 3 -f null - 2>&1 | grep -oE 'crop=[0-9]+' | tail -1 | cut -d= -f2
}

# Saved as 4:4:4 JPEG at top quality: the default 4:2:0 subsampling halves
# colour resolution, softening white-on-blue text edges before the platforms
# recompress the image again. Quicksand renders in its light weight; a
# same-colour border thickens the strokes so text survives downscaling.
ENC=(-frames:v 1 -q:v 1 -pix_fmt yuvj444p)

# --- default: logo, name, rule, tagline, URL --------------------------------
logo 166 171 "$TMP/logo_small.png"
ffmpeg -hide_banner -loglevel error -y -i "$BG" -i "$TMP/logo_small.png" -filter_complex "\
[0]scale=-2:630,crop=1200:630[bg];\
[bg][1]overlay=x=(W-w)/2:y=42[b];\
[b]drawtext=fontfile=$FONT:textfile=$TMP/name.txt:fontsize=84:fontcolor=white:borderw=2:bordercolor=white:x=(w-text_w)/2:y=236,\
drawbox=x=(iw-140)/2:y=352:w=140:h=4:color=white@0.6:t=fill,\
drawtext=fontfile=$FONT:textfile=$TMP/l1.txt:fontsize=50:fontcolor=white:borderw=1:bordercolor=white:x=(w-text_w)/2:y=390,\
drawtext=fontfile=$FONT:textfile=$TMP/l2.txt:fontsize=42:fontcolor=white@0.9:borderw=1:bordercolor=white@0.9:x=(w-text_w)/2:y=458,\
drawtext=fontfile=$FONT:textfile=$TMP/url.txt:fontsize=30:fontcolor=white@0.75:x=(w-text_w)/2:y=560" \
    "${ENC[@]}" "$DEFAULT"
ok "wrote $DEFAULT ($(( $(stat -c%s "$DEFAULT") / 1024 )) KB)"

# --- LinkedIn: logo left, "Médecine / Libre" right, group centred -----------
LOGO_W=388; GAP=56; SIZE=128
logo "$LOGO_W" 400 "$TMP/logo_big.png"
TEXT_W=$(text_width "$TMP/name1.txt" "$SIZE" 3)
X0=$(( (1200 - LOGO_W - GAP - TEXT_W) / 2 ))
TX=$(( X0 + LOGO_W + GAP ))
ffmpeg -hide_banner -loglevel error -y -i "$BG" -i "$TMP/logo_big.png" -filter_complex "\
[0]scale=-2:630,crop=1200:630[bg];\
[bg][1]overlay=x=$X0:y=(H-h)/2[b];\
[b]drawtext=fontfile=$FONT:textfile=$TMP/name1.txt:fontsize=$SIZE:fontcolor=white:borderw=3:bordercolor=white:x=$TX:y=170,\
drawtext=fontfile=$FONT:textfile=$TMP/name2.txt:fontsize=$SIZE:fontcolor=white:borderw=3:bordercolor=white:x=$TX:y=318" \
    "${ENC[@]}" "$LINKEDIN"
ok "wrote $LINKEDIN ($(( $(stat -c%s "$LINKEDIN") / 1024 )) KB)"
