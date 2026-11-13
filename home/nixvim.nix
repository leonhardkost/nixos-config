{
  config,
  lib,
  pkgs,
  self,
  ...
}:
{
  home.packages = lib.mkIf config.nix-leonhard.neovim.enable [
    self.packages.${pkgs.stdenv.hostPlatform.system}.nixvim
  ];

  home.sessionVariables = lib.mkIf config.nix-leonhard.neovim.enable {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
