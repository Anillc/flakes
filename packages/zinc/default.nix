{ pkgs, lib, runCommand, buildGoModule, fetchFromGitHub, ... }:

with builtins;
with lib;

let
    pname = "zinc";
    version = "0.2.5";
    source = fetchFromGitHub {
        owner = "zinclabs";
        repo = pname;
        rev = "v${version}";
        sha256 = "sha256-csHPvaCQi9uLFmhClMc+5r5QeMmzC5DJTQmCk/PksTA=";
    };
    web-packages = (import ./web-packages.nix { inherit pkgs; }).nodeDependencies;
    src = runCommand "zinc" {} ''
        mkdir -p $out
        cp -r ${source}/. $out/ && chmod -R +w $out
        ln -s ${web-packages}/lib/node_modules $out/web/node_modules
        cd $out/web && ${pkgs.nodejs-16_x}/bin/npm run build
    '';
in buildGoModule {
    inherit pname version src;
    vendorSha256 = "sha256-Y+0qisMnBzvRvgTo6t9BBiyv3LQ97sk8jUaxiv6WxRA=";
    checkPhase = ":";
}