{
  config,
  lib,
  ...
}:
{
  imports = [
    ./opts.nix
    ./keymaps.nix
    ./plugins
  ];

  options.kekleo.neovim.enable = lib.mkEnableOption "neovim";

  config = lib.mkIf config.kekleo.neovim.enable {
    programs.nixvim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      defaultEditor = true;

      colorschemes.tokyonight.enable = true;

      clipboard.providers.wl-copy.enable = true;

      globals.mapleader = " ";
    };
  };
}
