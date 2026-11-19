{
  config,
  ...
}:
{
  programs.firefox.enable = config.nix-leonhard.graphical.enable;
}
