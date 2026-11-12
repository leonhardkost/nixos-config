{
  config,
  lib,
  pkgs,
  self,
  ...
}:
{
  options.nix-leonhard.neovim.enable = lib.mkEnableOption "neovim";

  config = lib.mkIf config.nix-leonhard.neovim.enable {
    home.packages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.nixvim ];
  };
}
