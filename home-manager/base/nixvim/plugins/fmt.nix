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
        format_on_save = ''
          function(bufnr)
            local disable_filetypes = { c = true, cpp = true }
            local lsp_format_opt
            if disable_filetypes[vim.bo[bufnr].filetype] then
              lsp_format_opt = 'never'
            else
              lsp_format_opt = 'fallback'
            end
            return {
              timeout_ms = 500,
              lsp_format = lsp_format_opt,
            }
          end
        '';

        formatters_by_ft = {
          lua = [ "stylua" ];
          nix = [ "nixfmt" ];
          python = [ "black" ];
        };
      };
    };

    extraPackages = with pkgs; [
      stylua
      nixfmt
      black
    ];
  };
}
