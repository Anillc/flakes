pkgs:

with builtins;
with pkgs.lib;

let
    files = builtins.attrNames (removeAttrs (builtins.readDir ./.) [ "default.nix" ]);
in listToAttrs (map (x: nameValuePair x (pkgs.callPackage ./${x} {})) files)