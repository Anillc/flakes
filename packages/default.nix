pkgs:

with builtins;
with pkgs.lib;

rec {
    packages = let
        files = builtins.attrNames (removeAttrs (builtins.readDir ./.) [ "default.nix" ]);
    in listToAttrs (map (x: nameValuePair x (pkgs.callPackage ./${x} packages)) files);

    overlay = self: super: packages;
}