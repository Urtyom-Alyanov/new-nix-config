{
  pkgs,
  lib,
  config,
}:

with lib;

let
  cfg = config.modules.packageManagment;
in
{
  options.modules.packageManagment = {
    enable = mkEnableOption "Конфигурация пакетного менеджера Nix и, может быть, других пакетных менеджеров";

    features = mkOption {
      type = types.listOf types.str;
    };
  };
}
