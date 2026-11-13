{
  lib,
  ...
}:
{
  options.nix-leonhard = {
    graphical = lib.mkEnableOption "GUI features and programs";
    neovim.enable = lib.mkEnableOption "neovim";
  };
}
