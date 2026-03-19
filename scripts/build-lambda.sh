#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

LAMBDA_NAME="$1"
OUTPUT_DIR="${PROJECT_ROOT}/dist"

mkdir -p "$OUTPUT_DIR"

echo "Building ${LAMBDA_NAME}..."

GOOS=linux GOARCH=arm64 CGO_ENABLED=0 go build \
    -trimpath \
    -ldflags="-s -w -buildid=" \
    -o "${OUTPUT_DIR}/bootstrap" \
    "${PROJECT_ROOT}/cmd/${LAMBDA_NAME}"

# Set deterministic timestamp for reproducible builds
touch -t 202401010000.00 "${OUTPUT_DIR}/bootstrap"

cd "$OUTPUT_DIR"
zip -X "${LAMBDA_NAME}.zip" bootstrap
rm bootstrap

echo "Built ${OUTPUT_DIR}/${LAMBDA_NAME}.zip"