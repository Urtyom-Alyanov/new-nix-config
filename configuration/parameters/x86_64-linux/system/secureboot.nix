{
  pkgs,
  lib,
  config,
}:
with lib;

let
  cfg = config.modules.kernel.bootloader.secureboot;
in
{
  options.modules.kernel.bootloader.secureboot = {
    enable = mkEnableOption "Подпись ядра и загрузчка для использования вместе с безопасной загрузкой";

    excludeMicrosoftPaths = mkOption {
      type = types.bool;
      default = true;
      description = "Исключить пути загрузчика Windows из подписания";
    };

    enrollKeysOnSetupMode = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Вставить ключи в хранилище в Setup Mode";
      };

      includeMicrosoftKeys = mkOption {
        type = types.bool;
        default = true;
        description = "Включить также ключи Microsoft";
      };
    };

    createKeys = mkOption {
      type = types.bool;
      default = true;
      description = "Создание ключей при их отсутствии";
    };
  };

  config = mkIf cfg.enable {
    boot.loader.systemd-boot.extraInstallCommands = ''
      ${mkIf opts.createKeys ''
        if [ "$(${pkgs.sbctl}/bin/sbctl status --json | ${pkgs.jq}/bin/jq -r '.installed')" = "false" ]; then
                  ${pkgs.sbctl}/bin/sbctl create-keys
                fi''}
      ${mkIf opts.enrollKeysOnSetupMode.enable ''
        if [ "$(${pkgs.sbctl}/bin/sbctl status --json | ${pkgs.jq}/bin/jq -r '.setup_mode')" = "true" ]; then
                  ${pkgs.sbctl}/bin/sbctl enroll-keys ${mkIf opts.enrollKeysOnSetupMode.includeMicrosoftKeys "-m"}
                fi''}
      ${pkgs.sbctl}/bin/sbctl verify --json | \
      ${pkgs.jq}/bin/jq -r '.[] | select(.is_signed == 0 ${mkIf cfg.excludeMicrosoftPaths ''and (.file_name | test("Microsoft/Boot") | not)''}) | .file_name' | \
      while read filename; do
        ${pkgs.sbctl}/bin/sbctl sign "$filename"
      done
    '';
  };
}
