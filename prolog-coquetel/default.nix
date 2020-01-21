{ stdenv, pandoc }:

let revealjs-url = "https://cdn.jsdelivr.net/npm/reveal.js@3.8.0";
in stdenv.mkDerivation {
  name = "prolog-coquetel";
  description = "Resolvendo desafios de Lógica da Coquetel com Prolog";
  src = ./.;
  buildPhase = ''
    ${pandoc}/bin/pandoc \
      -t revealjs \
      -s \
      -o apresentação.html \
      -V revealjs-url=${revealjs-url} \
      -V theme=black \
      -V parallaxBackgroundImage=logo2.png \
      --css reveal_style.css \
      --css code_style.css \
      --slide-level 3 \
      --mathjax \
      src/apresentação.org
  '';
  installPhase = ''
    mkdir -p $out
    cp apresentação.html \
      src/exemplo_desafio.jpg \
      src/logo2.png \
      src/code_style.css \
      src/reveal_style.css \
      $out/
  '';
}
