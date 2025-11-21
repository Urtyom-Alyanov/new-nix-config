{ lib, flake }:
let
  availableArchitectures = lib.getAvailableArchitectures "${flake.configuration.path}/machines";

  buildMachines =
    arch:
    let
      archDir = "${flake.configuration.path}/machines/${arch}";
      machines = builtins.attrNames (builtins.readDir archDir);

      buildMachine =
        
            {
              name = "${machine}.${arch}";
              value = lib.mkMachine (
                let
                  config = import configPath { inherit inputs flake; };
                in
                config
                // {
                  system = arch;
                }
              );
            }
          ]
        else
          lib.throw "No configuration found for machine '${machine}' on architecture '${arch}' (expected at: ${configPath})";
    in
    builtins.concatLists (map buildMachine machines);

  allMachines = builtins.concatLists (map buildMachines availableArchitectures);
in
builtins.listToAttrs allMachines
