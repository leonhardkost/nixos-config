{ pkgs, lib, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # no greeting
      set fish_greeting
      # vi key binds
      set -g fish_key_bindings fish_vi_key_bindings
      # accept completion with ctrl-y
      bind --mode insert \cy forward-char
    '';
    shellAbbrs = {
      la = "ls -lahH";
    };
    plugins = with pkgs.fishPlugins; [
      {
        name = "tide";
        inherit (tide) src;
      }
    ];
  };

  home.activation.configure-tide = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -e "$HOME/.config/fish/tide_configured" ]; then
      echo "Configuring Tide..."
      $DRY_RUN_CMD ${pkgs.fish}/bin/fish -c "tide configure --auto --style=Lean --prompt_colors='16 colors' --show_time=No --lean_prompt_height='Two lines' --prompt_connection=Disconnected --prompt_spacing=Compact --icons='Few icons' --transient=Yes"
      $DRY_RUN_CMD touch "$HOME/.config/fish/tide_configured"
      echo "Finish Configuring Tide..."
    fi
  '';
}
