{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.nix-leonhard.graphical.enable {
    programs.hyprland.enable = true;
  };
}
