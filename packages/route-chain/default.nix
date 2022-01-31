{ pkgs, ... }: pkgs.stdenv.mkDerivation {
    name = "route-chain";
    src = pkgs.fetchgit {
        url = "https://github.com/xddxdd/route-chain.git";
        rev = "b2068ce2905588f445ff95a05c00f200ec96d5b5";
        sha256 = "sha256-AW4Tc8RCP0vyRUtZxUuNSYh/iYZh9ExZrsbgZHkFPqU=";
    };
    installPhase = ''
        mkdir -p $out/bin
        install -m 755 route-chain $out/bin
    '';
}