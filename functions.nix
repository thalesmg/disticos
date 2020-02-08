with (import ./nixpkgs.nix);
buildGoModule {
  name = "lambda-functions";
  src = ./netlify/fns;
  modSha256 = "1f4axlzjsikma2ccqihyjkz5b8f9gyi643am855imy9mi17mggh4";
}
