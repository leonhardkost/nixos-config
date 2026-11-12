{
  imports = [
    ./opts.nix
    ./keymaps.nix
    ./plugins
  ];

  viAlias = true;
  vimAlias = true;

  colorschemes.tokyonight.enable = true;

  clipboard.providers.wl-copy.enable = true;

  globals.mapleader = " ";
}
