{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.nix-leonhard.graphical.enable {
    services.displayManager.ly.enable = true;
  };
}
