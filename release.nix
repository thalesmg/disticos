let nixpkgs = import ./nixpkgs.nix;
in { prolog-coquetel = nixpkgs.callPackage ./prolog-coquetel { }; }
