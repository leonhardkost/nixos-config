{
  config,
  lib,
  pkgs,
  ...
}:
{

  config = lib.mkIf config.kekleo.graphical {
    home.packages = with pkgs; [ nordzy-cursor-theme ];

    programs.waybar.enable = true;

    wayland.windowManager.hyprland =
      let
        # workspaces
        # binds $mod/alt + [shift +] {1..9} to [move to] workspace {1..9}
        workspaces = builtins.concatLists (
          builtins.genList (
            i:
            let
              ws = toString (i + 1);
            in
            [
              "$mod,${ws},workspace,${ws}"
              "ALT,${ws},workspace,${ws}"
              "$mod SHIFT,${ws},movetoworkspace,${ws}"
              "ALTSHIFT,${ws},movetoworkspace,${ws}"
            ]
          ) 9
        );
      in
      {
        enable = true;
        package = pkgs.hyprland;

        xwayland.enable = true;

        settings = {
          env = [
            "HYPRCURSOR_THEME,Nordzy-cursors"
            "HYPRCURSOR_SIZE,26"
          ];
          monitor = [
            ",1920x1080@60,0x0,1"
          ];
          "$mod" = "SUPER";
          "$launcher" = "rofi -show drun";
          bind = [
            "ALTSHIFT,Q,killactive,"
            "ALT,V,togglefloating,"
            "ALT,F,fullscreen,1"
            "ALTSHIFT,F,fullscreen,0"
            "$mod,Return,exec,kitty"
            "$mod,F,exec,firefox"
            "$mod,R,exec,$launcher"

            "ALT,H,movefocus,l"
            "ALT,L,movefocus,r"
            "ALT,K,movefocus,u"
            "ALT,J,movefocus,d"
            "ALTSHIFT,H,movewindow,l"
            "ALTSHIFT,L,movewindow,r"
            "ALTSHIFT,K,movewindow,u"
            "ALTSHIFT,J,movewindow,d"
          ]
          ++ workspaces;

          windowrule = "border_size 0, match:fullscreen_state_client 1";

          general = {
            gaps_in = 2;
            gaps_out = 2;
            "col.active_border" = "0xff888888";
          };
          animations.animation = [
            "windows,1,4,default"
            "border,1,5,default"
            "fadeIn,1,5,default"
            "workspaces,1,3,default"
          ];

          dwindle.force_split = 2;
          cursor.no_warps = true;
        };
      };
  };
}
