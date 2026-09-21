{ pkgs, ... }:
{
  programs.nixvim = {
    opts.formatexpr = "v:lua.require'conform'.formatexpr()";

    plugins.conform-nvim = {
      enable = true;
      lazyLoad.enable = true;
      lazyLoad.settings = {
        event = "BufWritePre";
        cmd = "ConformInfo";
        keys = [
          {
            __unkeyed-1 = "<leader>f";
            __unkeyed-2.__raw = ''
              function() require 'conform'.format { async = true } end
            '';
            desc = "Format Buffer";
          }
        ];
      };
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
          python = [ "ruff" ];
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
