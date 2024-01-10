#!/bin/sh
# scripts/parse_tag_id.sh

# Extract the tag ID from GITHUB_REF
TAG_ID=${GITHUB_REF#refs/tags/bundleId-}
echo "TAG_ID=$TAG_ID" >> $GITHUB_ENV
