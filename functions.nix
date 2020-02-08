with (import ./nixpkgs.nix).pkgsMusl;
buildGoModule {
  name = "lambda-functions";
  src = ./netlify/fns;
  buildInputs = [ glibc.static ];
  modSha256 = "1f4axlzjsikma2ccqihyjkz5b8f9gyi643am855imy9mi17mggh4";
  # CFLAGS="-I${pkgs.glibc.dev}/include";
  # LDFLAGS="-L${pkgs.glibc}/lib";
  LDFLAGS = "-s -w -linkmode external -extldflags -static";
}
