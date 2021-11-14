#!/usr/bin/env bash

ls -la ./target/aarch64-apple-darwin/debug
ls -la ./target/x86_64-apple-darwin/debug
lipo -create -output fatbinary target/aarch64-apple-darwin/debug/fatbinary target/x86_64-apple-darwin/debug/fatbinary
ls -la
