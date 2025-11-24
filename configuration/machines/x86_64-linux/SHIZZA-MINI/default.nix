{
  inputs,
  flake,
  machinePath,
  lib,
}:
{
  hostname = "SHIZZA-MINI";
  modules = lib.allExceptThisDefault machinePath;
}
