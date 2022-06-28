# Anillc's flakes

## Usage

```nix
{
    inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    inputs.anillc = {
        url = "github:Anillc/flakes";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, anillc }: {
        nixosConfigurations.default = nixpkgs.lib.nixosSystem rec {
            system = "x86_64-linux";
            modules = [
                anillc.nixosModule.${system}
                ./configuration.nix
            ];
        };
    };
}
```