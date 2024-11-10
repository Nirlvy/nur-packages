# Nirlvy's Nix User Repository

**My personal [NUR](https://github.com/nix-community/NUR) repository**

![Build and populate cache](https://github.com/nirlvy/nur-packages/workflows/Build%20and%20populate%20cache/badge.svg)

[![Cachix Cache](https://img.shields.io/badge/cachix-nirlvy-blue.svg)](https://nirlvy.cachix.org)

Run packages directly from this repository(no cache):

```sh
nix run github:nirlvy/nur-packages#some-package
```

```nix
# flake.nix
{
  nixConfig = {
    extra-substituters = [ "https://nirlvy.cachix.org" ];
    extra-trusted-public-keys = [ "nirlvy.cachix.org-1:dOdsWPG0r4JuqWy+p150yPiVrC28tELUZUdkXobrKZM=" ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur-nirlvy = {
      url = "github:nirlvy/nur-packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nur-nirlvy, ... }@inputs: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [
        ({ pkgs, ... }: {
          environment.systemPackages = with pkgs; [
            nur-nirlvy.packages.${system}.some-package
          ];
        })
      ];
    };
  };
}
```

## LICENSE

[MIT](./LICENSE)
