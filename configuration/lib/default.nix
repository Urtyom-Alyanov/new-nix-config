{ flake, inputs }:
let
  allExceptThisDefault =
    dir:
    (builtins.readDir dir)
    |> (attrs: builtins.removeAttrs attrs [ "default.nix" ])
    |> builtins.attrNames
    |> map (entry: "${toString dir}/${entry}");
in
{
  allExceptThisDefault = allExceptThisDefault;
  imports = allExceptThisDefault ./. { inherit flake inputs; };
}
