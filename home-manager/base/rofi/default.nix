{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.kekleo.graphical {
    programs.rofi = {
      enable = true;
      theme = ./tokyonight.rasi;
      settings = {
        modi = [
          "drun"
          "window"
          "run"
        ];
        font = "JetBrainsMono Nerd Font 11";
        icon-theme = "Papirus-Dark";
        show-icons = true;
        terminal = "kitty";
        drun-display-format = "{icon} {name}";
        location = 0;
        disable-history = false;
        sidebar-mode = false;
        display-drun = " ";
        display-run = " ";
        display-window = " ";

        kb-row-up = "Up,Control+k";
        kb-row-left = "Left,Control+h";
        kb-row-right = "Right,Control+l";
        kb-row-down = "Down,Control+j";

        kb-accept-entry = "Return";
        # remove clashing keybinds
        kb-remove-to-eol = "";
        kb-move-char-back = "Control+b";
        kb-remove-char-back = "BackSpace";
        kb-move-char-forward = "Control+f";
        kb-mode-complete = "Control+o";
      };
    };
  };
}
