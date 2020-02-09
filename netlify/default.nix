let
  base-nixpkgs = import <nixpkgs> {};
  mozillaOverlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
  nixpkgs = import <nixpkgs> { overlays = [ mozillaOverlay ]; };
  rust = (nixpkgs.rustChannelOf { channel = "stable"; }).rust.override {
    targets = [ "x86_64-unknown-linux-musl" ];
  };
  rustPlatform = nixpkgs.makeRustPlatform {
    cargo = rust;
    rustc = rust;
  };
in

rustPlatform.buildRustPackage {
  name = "rust-static-nix";
  src = ./.;
  cargoSha256 = "1cqj14x63wv7b00x66rc401200r2hs5z5qiz80hwi01c0n65dy0j";
  target = "x86_64-unknown-linux-musl";
}
