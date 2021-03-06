let nixpkgs = import ./nixpkgs.nix;
in {
  prolog-coquetel = nixpkgs.callPackage ./prolog-coquetel { };
  polysemy-vdp = nixpkgs.callPackage ./polysemy-vdp { };
  frp = nixpkgs.callPackage ./frp { };
  dhall-kubernetes = nixpkgs.callPackage ./dhall-kubernetes { };
}
