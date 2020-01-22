let
  nixpkgs = import ./nixpkgs.nix;
  presentations = import ./.;
  index = nixpkgs.writeText "index.html" (''
  <!DOCTYPE html>
  <html>
    <head>
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <style>
        body { font-family: sans-serif; }
        .darkest-blue { background-color: #181a26; }
        .gold { text: #ffb700; }
        a { color: #ffb700; }
        a:visited { color: #ffb700; }
      </style>
    </head>
    <body class="darkest-blue gold">
      <ul>
  ''
    +
    nixpkgs.lib.strings.concatMapStrings (p: ''
      <li><a href="./static/${p}/apresentação.html">${presentations.${p}.description}</a></li>
      '') (builtins.attrNames presentations)
    +
  ''
      </ul>
    </body>
  </html>
  '');
in nixpkgs.runCommand "presentations" { } ((builtins.concatStringsSep "\n"
  (nixpkgs.lib.attrsets.mapAttrsToList (name: presentation: ''
    mkdir -p $out/static/${name}
    cp -r ${presentation}/* $out/static/${name}/
  '') presentations)) + ''

    cp ${index} $out/index.html
  '')
