{ lib, buildEmscriptenPackage, ... }:

with builtins;
with lib;

buildEmscriptenPackage {
    name = "tinyemu";
    src = fetchTarball {
        url = "https://bellard.org/tinyemu/tinyemu-2019-12-21.tar.gz";
        sha256 = "sha256:0w1krq77nqjkm09mw9hn1r3dxqx7knraqabypg2p2fpqjafx0f9j";
    };
    patches = [ ./makefile.patch ];
    configurePhase = ":";
    checkPhase = ":";
    buildPhase = ''
        mkdir -p .emscriptencache
        export EM_CACHE=$(pwd)/.emscriptencache
        make -f Makefile.js
    '';
    installPhase = ''
        mkdir -p $out
        cp -r js $out
    '';
}