{
  config,
  pkgs,
  ...
}:
{
  programs.kitty = {
    enable = config.nix-leonhard.graphical.enable;
    themeFile = "tokyo_night_night";
    font = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono NF";
      size = 14;
    };
    keybindings = {
      "ctrl+alt+enter" = "launch --cwd=current";
    };
    settings = {
      hide_window_decorations = true;
    };
  };
}
