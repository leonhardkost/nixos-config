{ pkgs, ... }:
{
  imports = [
    ./blink.nix
    ./dap.nix
    ./lsp.nix
    ./fmt.nix
    ./treesitter.nix
    ./telescope.nix
    ./lualine.nix
    ./which-key.nix
  ];

  extraPlugins = with pkgs.vimPlugins; [
    vim-sleuth
  ];
}
