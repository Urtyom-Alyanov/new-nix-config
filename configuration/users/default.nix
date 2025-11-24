{
  flake,
  ...
}:
let
  getUsers =
    dir:
    builtins.filter (user: (builtins.readDir dir)."${user}" == "directory") (
      builtins.attrNames (builtins.readDir dir)
    );
in
{
  imports = map (user: "${flake.path}/users/${user}") (getUsers ./.);
}
