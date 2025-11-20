{ inputs }:
{
  nixpkgs.overlays = [
    (final: prev: {
      flakes = {
        loginom-community = inputs.loginom.packages.${final.system}.loginom-community;
        hyprland = inputs.hyprland.packages.${final.system}.hyprland;
        xdg-desktop-portal-hyprland = inputs.hyprland.packages.${final.system}.xdg-desktop-portal-hyprland;
        hyprlandPlugins = inputs.hyprland-plugins.packages.${final.system} // {
          hypr-dynamic-cursors = inputs.hypr-dynamic-cursors.packages.${final.system}.hypr-dynamic-cursors;
        };
      };

      # Use standard NixOS repos
      stable = import inputs.nixpkgs-stable {
        inherit (final) system;
        config = {
          allowBroken = true;
        };
      };
      unstable = import inputs.nixpkgs-unstable {
        inherit (final) system;
        config = {
          allowBroken = true;
        };
      };

      # Use NixOS repos with pr*prietary software
      stable-proprietary = import inputs.nixpkgs-stable {
        inherit (final) system;
        config = {
          allowBroken = true;
          allowUnfree = true;
        };
      };
      unstable-proprietary = import inputs.nixpkgs-unstable {
        inherit (final) system;
        config = {
          allowBroken = true;
          allowUnfree = true;
        };
      };
    })
  ];
}
