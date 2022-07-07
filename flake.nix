{
    description = "Anillc's nix packages";
    inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    inputs.flake-utils.url = "github:numtide/flake-utils";

    outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachSystem [ "x86_64-linux" ] (system: let
        apps = import ./apps pkgs;
        module = import ./modules overlay;
        pkgs = import nixpkgs { inherit system; };
        inherit (import ./packages pkgs) overlay packages;
    in with builtins; with pkgs.lib; {
        nixosModules.default = module;
        packages = packages // {
            default = pkgs.runCommand "packages" {
                propagatedBuildInputs = filter (x: x ? ci -> x.ci) (attrValues packages);
            } "mkdir -p $out";
        };
        inherit apps;
    });
}