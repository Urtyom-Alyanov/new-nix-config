{
  lib,
  config,
  pkgs,
}:
with lib;
let
  cfg = config.modules.system.shell.fish;
in
{
  options.modules.system.shell.fish = {
    enable = mkEnableOption "Использовать Fish";

    setAsDefaultShell = mkOption {
      type = types.bool;
      default = true;
      description = "Использовать Fish в качестве оболочки по умолчанию для пользователей";
    };
  };

  config = mkIf cfg.enable {
    programs.fish.enable = true;
    users.defaultUserShell = mkIf cfg.setAsDefaultShell pkgs.fish;
  };
}
