{
  lib,
  ...
}:
{
  options.nix-leonhard = with lib.types; {
    graphical = lib.mkEnableOption "GUI features and programs";
    neovim.enable = lib.mkEnableOption "neovim";
  };
}
