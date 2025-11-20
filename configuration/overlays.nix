{ pkgs, inputs }: {
  overlays = [
    (final: prev: {
      loginom-community = inputs.loginom.packages.${final.system}.loginom-community;
      hyprland = inputs.hyprland.packages.${final.system}.hyprland;
      xdg-desktop-portal-hyprland = inputs.hyprland.packages.${final.system}.xdg-desktop-portal-hyprland;
      hyprlandPlugins = inputs.hyprland-plugins.packages.${final.system} // {
        hypr-dynamic-cursors = inputs.hypr-dynamic-cursors.packages.${final.system}.hypr-dynamic-cursors;
      };
    })
  ];
}