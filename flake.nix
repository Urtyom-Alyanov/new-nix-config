{
  description = "Мой фембой сетап нв NixOS nya~~";

  inputs = {
    # Flake exts
    flake-parts.url = "github:hercules-ci/flake-parts";

    # Nix pkgs
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    nixpkgs.follows = "nixpkgs-unstable";

    # Flake pkgs
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hypr-dinamic-cursors = {
      url = "github:VirtCode/hypr-dynamic-cursors";
      inputs.hyprland.follows = "hyprland";
    };
    loginom = {
      url = "github:Urtyom-Alyanov/loginom-community-package";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # plasma-manager = {
    #   url = "github:nix-community/plasma-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.home-manager.follows = "home-manager";
    # };
  };
  outputs =
    { self, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = inputs.nixpkgs.lib.systems.flakeExposed;
      flake = rec {
        configuration = import ./configuration;

        lib = inputs.nixpkgs.lib.extend (
          _: _:
          import ./lib {
            inputs = inputs;
            flake = self;
          }
        );

        nixosConfigurations = import "${configuration.path}/machines" {
          inherit inputs lib;
          flake = self;
        };
      };
    };
}
