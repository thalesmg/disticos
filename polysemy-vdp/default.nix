{ stdenv, pandoc }:

let revealjs-url = "https://cdn.jsdelivr.net/npm/reveal.js@3.8.0";
in stdenv.mkDerivation {
  name = "polysemy-vdp";
  description = "Vôo de Pássaro: Polysemy, um sistema de efeitos";
  src = ./.;
  buildPhase = ''
    ${pandoc}/bin/pandoc \
      -t revealjs \
      -s \
      -o apresentação.html \
      -V revealjs-url=${revealjs-url} \
      -V theme=black \
      --css style.css \
      --css code_style.css \
      --slide-level 3 \
      --mathjax \
      apresentação.org
  '';
  installPhase = ''
    mkdir -p $out
    cp -r \
      apresentação.html \
      *.css \
      images/ \
      $out/
  '';
}
