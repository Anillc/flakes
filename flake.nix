{
    description = "Anillc's nix packages";
    inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    outputs = { self, nixpkgs }: let
        pkgs = import nixpkgs { system = "x86_64-linux"; overlays = [ self.overlay ]; };
    in {
        overlay = self: super: with self; {
            go-cqhttp = callPackage ./gocq {};
        };
        packages.x86_64-linux = {
            inherit (pkgs) go-cqhttp;
        };
        nixosModules.an = import ./modules;
    };
}