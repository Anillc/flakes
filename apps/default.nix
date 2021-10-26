pkgs: let
    files = builtins.attrNames (removeAttrs (builtins.readDir ./.) [ "default.nix" ]);
in builtins.foldl' (acc: x: acc // {
    "${x}" = pkgs.callPackage ./${x} {};
}) {} files