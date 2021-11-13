#!/bin/bash
# This script takes care of building your crate and packaging it for release
set -ex

deploy() {
    prev_dir=$(pwd)
    cd /tmp
    curl -L -O https://github.com/tcnksm/ghr/releases/download/"$GHRELEASER_VERSION"/ghr_"$GHRELEASER_VERSION"_darwin_amd64.zip
    unzip ghr_"$GHRELEASER_VERSION"_darwin_amd64.zip
    ghr_exe=$(pwd)/ghr_"$GHRELEASER_VERSION"_darwin_amd64/ghr
    cd "$prev_dir"
    [ -f ./universal ]
    export artifacts=./univeral
    echo "${CIRCLE_PROJECT_USERNAME}" "${CIRCLE_PROJECT_REPONAME}" "${CIRCLE_SHA1}" "${CIRCLE_TAG}" "${artifacts}"
    "$ghr_exe" -t "${GITHUB_TOKEN}" -u "${CIRCLE_PROJECT_USERNAME}" -r "${CIRCLE_PROJECT_REPONAME}" -c "${CIRCLE_SHA1}" -delete "${CIRCLE_TAG}" "${artifacts}"
}

if [ -z "$GITHUB_TOKEN" ]; then
    echo "Github access token not set, exitting."
fi

if [ -z "$GHRELEASER_VERSION" ]; then
    echo "ghr version was not set using v0.13.0"
    export GHRELEASER_VERSION="v0.13.0"
fi

deploy
