{
    overlay = self: super: let
        files = builtins.attrNames (removeAttrs (builtins.readDir ./.) [ "default.nix" ]);
    in builtins.foldl' (acc: x: acc // { "${x}" = self.callPackage ./${x} {}; }) {} files;
}