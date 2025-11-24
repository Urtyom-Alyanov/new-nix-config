{
  inputs,
  userPath,
  lib,
  flake,
  pkgs,
  ...
}:
{
  imports = [
    (import "${inputs.home-manager}/nixos")
  ];

  home-manager = import "${userPath}/home/default.nix" {
    inherit
      pkgs
      lib
      flake
      userPath
      ;
  };

  users.users.artemos = {
    isNormalUser = true;
    description = "Artem Klochkov";
    createHome = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "input"
      "adbusers"
      "video"
      "audio"
      "lp"
      "scanner"
    ];
  };
}
