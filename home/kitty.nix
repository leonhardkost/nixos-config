{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.nix-leonhard.graphical.enable {
    programs.kitty = {
      enable = true;
      themeFile = "tokyo_night_night";
      font = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono NF";
        size = 14;
      };
      keybindings = {
        "ctrl+alt+enter" = "launch --cwd=current";
      };
    };
  };
}
