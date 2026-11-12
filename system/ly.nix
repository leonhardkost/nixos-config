{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.nix-leonhard.graphical {
    services.displayManager.ly.enable = true;
  };
}
