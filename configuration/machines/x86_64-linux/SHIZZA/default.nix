{
  inputs,
  flake,
  machinePath,
  lib,
}:
{
  hostname = "SHIZZA";
  modules = lib.allExceptThisDefault machinePath;
}
