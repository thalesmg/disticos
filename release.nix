let
  nixpkgs = import ./nixpkgs.nix;
  presentations = import ./.;
in nixpkgs.runCommand "presentations" { } ((builtins.concatStringsSep "\n"
  (nixpkgs.lib.attrsets.mapAttrsToList (name: presentation: ''
    mkdir -p $out/static/${name}
    cp -r ${presentation}/* $out/static/${name}/
  '') presentations)) + ''

    echo aaaaaaaaa
  '')
