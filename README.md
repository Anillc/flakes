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
        nixosConfigurations.default = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                (_: {
                    imports = [ anillc.nixosModule.x86_64-linux ];
                })
                ./configuration.nix
            ];
        };
    };
}
```