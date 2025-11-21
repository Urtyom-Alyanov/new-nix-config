{ inputs, flake, ... }:
let
  lib = inputs.nixpkgs.lib;
in
{
  mkMachine =
    {
      system ? "x86_64-linux",
      hostname,
      modules ? [ ],
    }:
    let
      finalSystem = system;
    in
    lib.nixosSystem {
      system = finalSystem;
      specialArgs = { inherit inputs flake; };
      modules = [
        { networking.hostName = hostname; }
        { system.stateVersion = flake.configuration.system.stateVersion; }
        "${flake.configuration.path}/overlays"
        "${flake.configuration.path}/homes"
      ]
      ++ modules;
    };
}
