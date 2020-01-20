{ stdenv, pandoc }:

let revealjs-url = "https://cdn.jsdelivr.net/npm/reveal.js@3.8.0";
in stdenv.mkDerivation {
  name = "frp";
  src = ./.;
  buildPhase = ''
    ${pandoc}/bin/pandoc \
      -t revealjs \
      -s \
      -o apresentação.html \
      -V revealjs-url=${revealjs-url} \
      -V theme=black \
      --css reveal_style.css \
      --css code_style.css \
      --slide-level 3 \
      --mathjax \
      apresentação.org
  '';
  installPhase = ''
    mkdir -p $out
    cp -r \
      apresentação.html \
      *.gif \
      *.png \
      *.css \
      $out/
  '';
}
