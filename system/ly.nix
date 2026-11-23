{
  config,
  ...
}:
{
  services.displayManager.ly = {
    enable = config.nix-leonhard.graphical.enable;
    settings.session_log = ".cache/ly-lession.log";
  };
}
