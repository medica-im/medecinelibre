# Environments and deploys

Three environments, two of them containerised.

| Environment | URL | Host (ssh alias) | What runs | Port |
|---|---|---|---|---|
| dev | https://dev.medecinelibre.com | `dev` | `vite dev`, hot reload | 5173 |
| staging | https://staging.medecinelibre.com | `staging` | built container | 3105 |
| production | https://medecinelibre.com | `blog` | built container | 3004 |

Production runs on the **`blog`** host, not the `production` one — that
alias is a different machine. `images.yml` records this; deploying to the
wrong host would quietly do nothing to the live site.

## Day to day

```bash
./scripts/dev.sh                 # vite dev on 0.0.0.0:5173
./scripts/dev.sh --local         # bind 127.0.0.1 instead
./scripts/dev.sh --port 5174
```

On the dev VPS nginx proxies dev.medecinelibre.com to this, so the site is
live on a phone while you edit, with no rebuild in the loop.

## Releasing

```bash
./scripts/release.sh staging             # build, push, deploy, health-check
./scripts/release.sh production          # prompts for confirmation
./scripts/release.sh staging --dry-run   # print, touch nothing
./scripts/release.sh staging --build-only
```

Or the two halves separately:

```bash
./scripts/build-image.sh staging
./scripts/deploy-image.sh staging
./scripts/build-image.sh --list
./scripts/deploy-image.sh --list
```

The deploy never builds on the server: it pulls the exact tag that was
pushed, so staging and production run the artefact you tested rather than
a rebuild that could drift.

## Rolling back

Every build pushes two tags: the moving one (`:production`, `:staging`)
and an immutable one from the commit sha (`:47cb4d9`). The second exists
so a bad deploy has somewhere to go back to — pushing `:production` alone
moves a single pointer and makes the displaced image unaddressable.

```bash
./scripts/deploy-image.sh production --tag 47cb4d9
```

Find a previous tag with:

```bash
docker image ls ghcr.io/medica-im/medecinelibre
```

## Environment files

`.env*` is gitignored, so **a fresh clone has none of them**. Copy them
from another machine, or start from `.env.example`:

- `.env.production.medecinelibre.com`
- `.env.staging.medecinelibre.com`
- `.env.dev.medecinelibre.com`

Which file a build bakes in comes from `env_file:` in `images.yml`.

### Why this matters more than it looks

The site reads env vars two different ways:

- `$env/static/public` — **compiled into the bundle at build time**
  (`PUBLIC_PLAUSIBLE_SCRIPT_SRC`, `PUBLIC_GOOGLE_SITE_VERIFICATION` in
  `src/routes/+layout.svelte`)
- `$env/dynamic/public` — **read at runtime** from the server's `.env`
  (`PUBLIC_SITE_TITLE` in `src/routes/pluripro/msp/+page.svelte`)

The old `build_push_production.sh` passed `--build-arg ENV_FILE=...` to a
Dockerfile that had no `ARG ENV_FILE`, so the flag was silently ignored
and every image compiled in whatever `.env` sat in the working tree. It
went unnoticed because adapter-node falls back to `process.env` at runtime
for `PUBLIC_`-prefixed vars, and compose injects the server's `.env` — so
production looked right while carrying the wrong value baked in.

A staging build under that Dockerfile would have shipped production's
Plausible tag, reporting staging traffic as production. The `ARG ENV_FILE`
in the Dockerfile is what fixes it; `com.medecinelibre.env-file` on the
image records which file was used.

## Server setup (once per environment)

nginx configs are in `scripts/nginx/`, with install instructions in their
headers. The dev one needs the websocket upgrade headers or HMR fails
silently — the page loads but never reloads.

A deploy directory needs only the compose file and a `.env`:

```
/opt/staging.medecinelibre.com/
  docker-compose-staging.yml
  .env                       # copy of .env.staging.medecinelibre.com
```

## Why there is no staging on a separate concern

There is — staging runs on its own VPS. What there deliberately is *not*
is a rebuild step on any server, or a third build path. Staging and
production differ only in which `.env` is baked in and which host the same
image lands on.
