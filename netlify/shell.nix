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
  cargoSha256 = "1v492hfi2dar7jjd0vw5665wi66jgwq30b0f038daajg7ij133na";
  target = "x86_64-unknown-linux-musl";
}
