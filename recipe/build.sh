#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

# check licenses
cargo-bundle-licenses \
    --format yaml \
    --output THIRDPARTY.yml

echo '[features]' >> cli/Cargo.toml
echo 'use-system-gmp = "gmp-mpfr-sys/use-system-libs"' >> cli/Cargo.toml

# build statically linked binary with Rust
cargo install --bins --no-track --locked --root ${PREFIX} --path cli

# strip debug symbols
"$STRIP" "$PREFIX/bin/${PKG_NAME}"
