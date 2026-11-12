{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.nix-leonhard.graphical {
    programs.hyprland.enable = true;
  };
}
