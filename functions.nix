with (import ./nixpkgs.nix);
buildGoModule {
  name = "lambda-functions";
  src = ./netlify/fns;
  buildInputs = [ glibc.static ];
  modSha256 = "1f4axlzjsikma2ccqihyjkz5b8f9gyi643am855imy9mi17mggh4";
  LDFLAGS = "-s -w -linkmode external -extldflags -static";
}
