#!/bin/bash

set -xe

wget -O nix-user-chroot https://github.com/nix-community/nix-user-chroot/releases/download/1.0.2/nix-user-chroot-bin-1.0.2-x86_64-unknown-linux-musl
chmod 0777 nix-user-chroot

wget -O proot https://gitlab.com/proot/proot/-/jobs/400664233/artifacts/raw/dist/proot
chmod 0777 proot

# mkdir -m 0755 -p .nix
# ./nix-user-chroot .nix bash -c "curl https://nixos.org/nix/install | sh"
# ./nix-user-chroot .nix "nix-build release.nix"

mkdir ~/.nix
./proot -b ~/.nix:/nix
curl https://nixos.org/nix/install | sh
nix-build release.nix
