{
  pkgs,
  inputs,
  ...
}:
{
  nixvim =
    (inputs.nixvim.lib.evalNixvim {
      inherit (pkgs) system;
      modules = [ ./nixvim ];
    }).config.build.package;
}
