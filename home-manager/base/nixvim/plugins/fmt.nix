{ pkgs, ... }:
{
  programs.nixvim = {
    opts.formatexpr = "v:lua.require'conform'.formatexpr()";

    keymaps = [
      {
        key = "<leader>f";
        action.__raw = ''
          function() require 'conform'.format { async = true } end
        '';
        options.desc = "Format Buffer";
      }
    ];

    plugins.conform-nvim = {
      enable = true;
      settings = {
        default_format_opts.lsp_format = "fallback";
        format_on_save = {
          lsp_format = "fallback";
          timeout_ms = 500;
        };

        formatters_by_ft = {
          c = [ "clang-format" ];
          lua = [ "stylua" ];
          nix = [ "nixfmt" ];
          python = [ "ruff_format" ];
        };

        formatters.clang-format.prepend_args = [
          "--style=file"
          "--fallback-style=LLVM"
        ];
      };
    };

    extraPackages = with pkgs; [
      stylua
      nixfmt
      ruff
    ];
  };
}
