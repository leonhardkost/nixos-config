{
  pkgs,
  inputs,
  ...
}:
{
  nixvim = inputs.nixvim.lib.buildNixvimWith {
    inherit (pkgs) system;
    modules = [ ./nixvim ];
  };
}
