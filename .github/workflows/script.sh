#!/usr/bin/env bash

# ls -la ./target/aarch64-apple-darwin/debug
# ls -la ./target/x86_64-apple-darwin/debug
set -ex

echo "Release: =$RELEASE="
echo "Y: =$Y="
echo "GITHUB_ENV: =$GITHUB_ENV="

lipo -create -output fatbinary target/aarch64-apple-darwin/debug/fatbinary target/x86_64-apple-darwin/debug/fatbinary
file ./fatbinary

./fatbinary

chmod u+x ./fatbinary
zip fatbinary.zip fatbinary
