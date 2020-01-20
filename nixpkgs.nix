let
  nixpkgs-src = builtins.fetchGit {
    # Descriptive name to make the store path easier to identify
    name = "nixpkgs-unstable-2020-01-20";
    url = "https://github.com/nixos/nixpkgs-channels";
    # Commit hash for nixos-unstable as of 2020-01-20
    # `git ls-remote https://github.com/nixos/nixpkgs-channels nixos-unstable`
    ref = "refs/heads/nixos-unstable";
    rev = "bea1a232c615aba177e0ef56600d5f847ad3bbd9";
  };
in import nixpkgs-src { }
