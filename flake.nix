{
    description = "Anillc's nix packages";
    inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    inputs.flake-utils = {
        url = "github:numtide/flake-utils";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    inputs.random-src = {
        url = "github:Anillc/random-src";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, flake-utils, random-src }: flake-utils.lib.eachDefaultSystem (system: let
        apps = import ./apps pkgs;
        nixosModule = import ./modules self.overlay.${system};
        pkgs = import nixpkgs { inherit system; overlays = [
            overlay
            (self: super: { inherit flake-utils; inherit (random-src.packages.${system}) random-src; })
        ]; };
        inherit (import ./packages) overlay;
    in {
        packages = {
            inherit (pkgs) go-cqhttp bird-lg-go bird-lg-go-frontend route-chain babelweb2 babelweb2-static random-src;
        };
        inherit overlay apps nixosModule;
    });
}