{ pkgs, ... }: pkgs.stdenv.mkDerivation {
    name = "babelweb2-static";
    src = pkgs.fetchgit {
        url = "https://github.com/Anillc/babelweb2.git";
        rev = "ea898cf65663c61166df9e4caf6d9b1542cefc84";
        sha256 = "sha256-sLDgI9DJS5FopfRL7tu86nhTRqpy8XeY3FTpAVGMi1o=";
    };
    buildPhase = ":";
    installPhase = ''
        mkdir -p $out
        cp -r static/* $out
    '';
}