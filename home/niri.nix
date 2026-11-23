{
  config,
  ...
}:
{
  wayland.windowManager.niri = {
    enable = config.nix-leonhard.graphical.enable;
  };
}
