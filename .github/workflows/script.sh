#!/usr/bin/env bash

# ls -la ./target/aarch64-apple-darwin/debug
# ls -la ./target/x86_64-apple-darwin/debug
# set -ex

echo "Release: =$RELEASE="
echo "RELEASE_COMMIT: =$RELEASE_COMMIT="
echo "Y: =$Y="
echo "GITHUB_ENV: =$GITHUB_ENV="
echo "FOOK: =$FOOK="
echo "GLOBAL: =$GLOBAL="

lipo -create -output fatbinary target/aarch64-apple-darwin/debug/fatbinary target/x86_64-apple-darwin/debug/fatbinary
file ./fatbinary

[ "$RELEASE_COMMIT" = "true" ] && ./fatbinary

chmod u+x ./fatbinary
zip fatbinary.zip fatbinary
