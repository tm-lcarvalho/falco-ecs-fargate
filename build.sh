#!/usr/bin/env bash

docker buildx build --platform=linux/x86_64 -t tmlcarvalho/falco:latest .
docker push tmlcarvalho/falco:latest

