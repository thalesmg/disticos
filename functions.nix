{ stdenv, buildGoModule }:

let
  lambda-events = buildGoModule rec {
    name = "aws-lambda-go-${version}";
    version = "v1.13.3";
    src = builtins.fetchGit {
      url = "https://github.com/aws/aws-lambda-go.git";
      ref = "v1.13.3";
    };
    goPackagePath = "github.com/aws/aws-lambda-go";
    subPackages = ["./events" "./lambda"];
    modSha256 = "1a8h5vvclbffhpw12jbdz30zn20x6ydxyjb8yibq46s63jq85i94";
  };

in buildGoModule {
  name = "lambda-functions";
  src = ./netlify/fns;
  buildInputs = [ lambda-events ];
  subPackages = [ "." ];
  modRoot = ./netlify/fns;
  modSha256 = "0sjjj9z1dhilhpc8pq4154czrb79z9cm044jvn75kxcjv6v5l2m5";
}
