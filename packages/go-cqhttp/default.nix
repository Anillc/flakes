{ stdenv, fetchurl, autoPatchelfHook, lib, system, ... }:

with builtins;
with lib;

let
    systems = {
        "x86_64-linux"   = "linux_amd64";
        "aarch64-linux"  = "linux_arm64";
        "armv7a-linux"   = "linux_armv7";
        "armv7l-linux"   = "linux_armv7";
        "x86_64-darwin"  = "darwin_amd64";
        "aarch64-darwin" = "darwin_arm64";
    };
    downloadSystem = systems.${system};
in stdenv.mkDerivation {
    name = "go-cqhttp";
    src = fetchurl {
        url = "https://github.com/Mrs4s/go-cqhttp/releases/download/v1.0.0-rc4/go-cqhttp_${downloadSystem}.tar.gz";
        sha256 = "sha256-otCnXsqBaJ02ZvaFcwDe8DiIrR+qwRvqxZRk6Jkgsbw=";
    };
    unpackCmd = "tar zvxf $src";
    sourceRoot = ".";
    installPhase = ''
        mkdir -p $out/bin
        install -m 755 go-cqhttp $out/bin
    '';
}