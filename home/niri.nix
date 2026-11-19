{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.nix-leonhard.graphical.enable {
    wayland.windowManager.niri = {
      enable = true;
    };
  };
}
