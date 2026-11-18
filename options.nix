{
  lib,
  ...
}:
{
  options.nix-leonhard = {
    graphical.enable = lib.mkEnableOption "GUI features and programs";
    neovim.enable = lib.mkEnableOption "neovim";
  };
}
