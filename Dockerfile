# syntax=docker/dockerfile:1
#
# Build targets: staging and production. Both run the same adapter-node
# server; they differ only in which .env file is baked in.
#
# ENV_FILE is why this file has an ARG at all. The build-arg was being
# passed by build_push_production.sh and silently ignored, so every image
# was built against whatever .env happened to sit in the working tree.
# That went unnoticed because $env/static/public falls back to process.env
# at runtime for PUBLIC_-prefixed vars, and compose injects the server's
# .env — so production looked correct while carrying the wrong value
# compiled in. A staging build would have inherited production's Plausible
# tag and reported staging traffic as production.
ARG NODE_VERSION=22

FROM node:${NODE_VERSION}-alpine AS builder

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable && npm install -g corepack@latest
WORKDIR /app

COPY . .

# Copied over .env before the build so $env/static/public compiles the
# right values in. Vite reads .env from the project root and nothing else,
# hence the copy rather than an --env-file flag.
ARG ENV_FILE=.env
RUN if [ ! -f "$ENV_FILE" ]; then \
        echo "error: ENV_FILE '$ENV_FILE' not found in build context." >&2; \
        echo "       .env* is gitignored — the file must exist locally." >&2; \
        exit 1; \
    fi && \
    cp "$ENV_FILE" .env

RUN --mount=type=cache,id=pnpm,target=/pnpm/store \
    pnpm install --frozen-lockfile
RUN pnpm run build

FROM node:${NODE_VERSION}-alpine AS runtime

WORKDIR /app
ENV NODE_ENV=production

# Recorded so a running container can be traced back to a commit:
#   docker inspect <image> --format '{{index .Config.Labels "org.opencontainers.image.revision"}}'
ARG GIT_SHA=unknown
ARG ENV_FILE=.env
LABEL org.opencontainers.image.revision="${GIT_SHA}"
LABEL com.medecinelibre.env-file="${ENV_FILE}"

COPY --from=builder /app/node_modules node_modules/
COPY --from=builder /app/build .
COPY --from=builder /app/package.json .

EXPOSE 3000
CMD [ "node", "index.js" ]

# Named targets so images.yml can select one; both are the same runtime.
FROM runtime AS staging
FROM runtime AS production
