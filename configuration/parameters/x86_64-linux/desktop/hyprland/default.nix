{
  inputs,
  lib,
  config,
}:
with lib;
let
  hyprland = inputs.hyprland.packages.x86_64-linux.hyprland;
  hyprlandPortal = inputs.hyprland.packages.x86_64-linux.portalPackage;
  cfg = config.modules.desktop.hyprland;
in
{
  options.modules.desktop.hyprland = {
    enable = mkEnableOption "Использовать Hyprland";

    xwayland = mkOption {
      type = types.bool;
      default = true;
      description = "Включить поддержку XWayland для запуска X11 приложений";
    };

    usingWaybar = mkOption {
      type = types.bool;
      default = false;
      description = "Использовать Waybar в качестве панели задач";
    };
  };

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = cfg.xwayland;
      package = hyprland;
      portalPackage = hyprlandPortal;
    };
  };
}
