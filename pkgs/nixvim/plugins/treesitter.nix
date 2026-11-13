{ pkgs, ... }:
{
  plugins.treesitter = {
    enable = true;
    nixGrammars = false;
  };

  extraConfigLua = ''
    local function start(buf, lang)
      if not vim.api.nvim_buf_is_valid(buf) then return end
      if not pcall(vim.treesitter.start, buf, lang) then return end

      -- indent (nvim-treesitter's indents.scm, experimental on main)
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

      -- folds (built into Neovim, uses folds.scm)
      vim.api.nvim_buf_call(buf, function()
        vim.wo[0][0].foldmethod = "expr"
        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
      end)
    end

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang then return end
        local ts = require("nvim-treesitter")
        if vim.tbl_contains(ts.get_installed(), lang) then
          start(args.buf, lang)
        elseif vim.tbl_contains(ts.get_available(), lang) then
          ts.install(lang):await(function() start(args.buf, lang) end)
        end
      end,
    })
  '';

  extraPackages = with pkgs; [
    gcc
    tree-sitter
  ];
}
