#!/usr/bin/env bash

# ls -la ./target/aarch64-apple-darwin/debug
# ls -la ./target/x86_64-apple-darwin/debug
set -ex

echo "Release: =$RELEASE="
echo "RELEASE_COMMIT: =$RELEASE_COMMIT="
echo "Y: =$Y="
echo "GITHUB_ENV: =$GITHUB_ENV="
echo "FOOK: =$FOOK="
echo "GLOBAL: =$GLOBAL="

if [[ "$GLOBAL" = "true" ]]; then
    ls -lh ./target/aarch64-apple-darwin/release/fatbinary
    ls -lh ./target/x86_64-apple-darwin/release/fatbinary
    lipo -create -output fatbinary target/aarch64-apple-darwin/release/fatbinary target/x86_64-apple-darwin/release/fatbinary
    file ./fatbinary
    chmod u+x ./fatbinary
    zip fatbinary.zip fatbinary
else
    ls -lh ./target/aarch64-apple-darwin/debug/fatbinary
    ls -lh ./target/x86_64-apple-darwin/debug/fatbinary
    lipo -create -output fatbinary target/aarch64-apple-darwin/debug/fatbinary target/x86_64-apple-darwin/debug/fatbinary
    ./fatbinary
fi

