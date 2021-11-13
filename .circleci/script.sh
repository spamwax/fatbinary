#!/usr/bin/env bash
# This script takes care of testing your crate

set -ex

run_tests() {
    runner="$1"
    working_dir="$2"
    # runner="cargo run --target "$TARGET" --"
    export alfred_debug=1
    export alfred_version="4.5.1"
    export alfred_workflow_version=0.16.0
    export alfred_workflow_uid=hamid63
    export alfred_workflow_name="RustyPin"
    export alfred_workflow_bundleid=cc.hamid.alfred-pinboard-rs
    workflow_dir="$working_dir/.config/alfred-pinboard-rs"
    mkdir -p "$workflow_dir"
    export alfred_workflow_data="$workflow_dir"
    export alfred_workflow_cache="$workflow_dir"
    case "$TARGET" in
        x86_64-apple-darwin)
            $runner config --authorization "${PINBOARD_TOKEN}"
            $runner update
            $runner config -d
            ;;
        x86_64-unknown-linux-gnu)
            ls -ld "$alfred_workflow_data"
            ls -ld "$alfred_workflow_cache"
            chown -R "$USER":"$USER" "$alfred_workflow_data"

            $runner config --authorization "${PINBOARD_TOKEN}"
            $runner update
            unset alfred_debug
            $runner config -d | .circleci/json_pretty.sh
            ;;
        i686-apple-darwin)
            $runner config --authorization "${PINBOARD_TOKEN}"
            $runner update
            $runner config -d
            ;;
        x86_64-unknown-freebsd)
            # $runner config --authorization "${PINBOARD_TOKEN}"
            # $runner config -d
            ;;
        armv7-linux-androideabi)
            $runner config --authorization "${PINBOARD_TOKEN}"
            $runner update
            $runner config -d
            ;;
        *)
            return
            ;;
    esac
    ls -la "$alfred_workflow_data"
    ls -la "$2"
    ls -la "$2/.config"
    rm -rf "$2/.config"

}

cargo update
cargo generate-lockfile
cargo build --target x86_64-apple-darwin

SDKROOT=$(xcrun -sdk macosx11.0 --show-sdk-path) MACOSX_DEPLOYMENT_TARGET=$(xcrun -sdk macosx11.0 --show-sdk-platform-version) cargo build --target=aarch64-apple-darwin

lipo -create -output universal target/aarch64-apple-darwin/debug/fatbinary target/x86_64-apple-darwin/debug/fatbinary

