{
    description = "Anillc's nix packages";
    inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    inputs.flake-utils = {
        url = "github:numtide/flake-utils";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system: let
        apps = import ./apps pkgs;
        nixosModule = import ./modules;
        pkgs = import nixpkgs { inherit system; overlays = [
            overlay
            (self: super: { inherit flake-utils; })
        ]; };
        inherit (import ./packages) overlay;
    in {
        packages = {
            inherit (pkgs) go-cqhttp;
        };
        inherit overlay apps nixosModule;
    });
}