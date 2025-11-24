{ ... }:
{
  getAvailableArchitectures =
    {
      directory ? ./.,
    }:
    builtins.filter (arch: (builtins.readDir directory)."${arch}" == "directory") (
      builtins.attrNames (builtins.readDir directory)
    );
}
