{ pkgs, ... }: pkgs.stdenv.mkDerivation {
    name = "rtrlib";
    src = pkgs.fetchgit {
        url = "https://github.com/rtrlib/rtrlib.git";
        rev = "d05a0b6ae8f779496200ec786981bafc94b17ead";
        sha256 = "sha256-WX7JwvRibN5csBMYPH11HK7VIA0OuRiRrU5RhCqkyEc=";
    };
    nativeBuildInputs = with pkgs; [ cmake ];
    buildInputs = with pkgs; [ libssh ];
}