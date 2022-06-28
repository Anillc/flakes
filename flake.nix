{
    description = "Anillc's nix packages";
    inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    inputs.flake-utils.url = "github:numtide/flake-utils";

    outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachSystem [ "x86_64-linux" ] (system: let
        apps = import ./apps pkgs;
        module = import ./modules overlay;
        pkgs = import nixpkgs { inherit system; };
        inherit (import ./packages pkgs) overlay packages;
    in {
        nixosModules.default = module;
        inherit packages apps;
    });
}