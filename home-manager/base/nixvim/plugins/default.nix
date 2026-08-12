{ pkgs, ... }:
{
  imports = [
    ./cmp.nix
    ./dap.nix
    ./lsp.nix
    ./fmt.nix
    ./treesitter.nix
    ./telescope.nix
    ./lualine.nix
    ./nvim-autopairs.nix
    ./which-key.nix
  ];

  programs.nixvim = {
    plugins = {
      lz-n.enable = true;
      indent-blankline.enable = true;
      web-devicons.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      vim-sleuth
    ];
  };
}
