# Nirlvy's Nix User Repository

**My personal [NUR](https://github.com/nix-community/NUR) repository**

![Build and populate cache](https://github.com/nirlvy/nur-packages/workflows/Build%20and%20populate%20cache/badge.svg)

[![Cachix Cache](https://img.shields.io/badge/cachix-nirlvy-blue.svg)](https://nirlvy.cachix.org)

## How to use

> **NOTE**: To follow the following usage, you need to have [Nix](https://nixos.org/nix/) installed with `flakes` & `new-commands` enabled first.

Run packages directly from this repository(no cache):

```sh
nix run github:nirlvy/nur-packages#some-package
```

Use this repository in `flake.nix`:

```nix
# flake.nix
{
  # the nixConfig here only affects the flake itself, not the system configuration!
  # for more information, see:
  #     https://nixos-and-flakes.thiscute.world/nixos-with-flakes/add-custom-cache-servers
  nixConfig = {
    # substituers will be appended to the default substituters when fetching packages
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
            # Add packages from this repo
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
