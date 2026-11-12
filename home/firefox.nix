{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.nix-leonhard.graphical {
    programs.firefox.enable = true;
  };
}
