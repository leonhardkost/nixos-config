{
  imports = [
    ./git.nix
    ./firefox.nix
    ./fish.nix
    ./nixvim.nix
    ./hyprland.nix
    ./kitty.nix
    ./rofi
  ];

  home = {
    username = "leonhard";
    homeDirectory = "/home/leonhard";
  };

  xdg.enable = true;
}
