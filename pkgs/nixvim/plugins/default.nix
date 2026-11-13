{
  imports = [
    ./blink.nix
    ./dap.nix
    ./lsp.nix
    ./fmt.nix
    ./treesitter.nix
    ./telescope.nix
    ./lualine.nix
  ];

  plugins = {
    sleuth.enable = true;
    which-key.enable = true;
  };
}
