#!/bin/bash

docker build --build-arg ENV_FILE=.env.production.medecinelibre.com -t ghcr.io/medica-im/medecinelibre:production .

if [ $? -eq 0 ]; then
    docker push ghcr.io/medica-im/medecinelibre:production
else
    echo "WARNING: Docker build failed. Image was not pushed."
    exit 1
fi
