{
  programs.nixvim = {
    opts.completeopt = [
      "menu"
      "menuone"
      "noselect"
    ];

    plugins = {
      lspkind.enable = true;

      cmp = {
        enable = true;

        autoEnableSources = true;

        settings = {
          snippet.expand = "function(args) vim.snippet.expand(args.body) end";

          formatting.fields = [
            "abbr"
            "icon"
            "menu"
          ];

          mapping = {
            "<C-p>" = "cmp.mapping.select_prev_item()";
            "<C-n>" = "cmp.mapping.select_next_item()";
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-y>" = "cmp.mapping.confirm({ select = true })";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-l>" = ''
              cmp.mapping(
                function()
                  if vim.snippet.active({ direction = 1 }) then
                    vim.snippet.jump(1)
                  end
                end,
                {'i', 's'}
              )
            '';
            "<C-h>" = ''
              cmp.mapping(
                function()
                  if vim.snippet.active({ direction = -1 }) then
                    vim.snippet.jump(-1)
                  end
                end,
                {'i', 's'}
              )
            '';
          };

          sources = [
            { name = "nvim_lsp"; }
            { name = "nvim_lsp_signature_help"; }
            { name = "path"; }
          ];
        };
      };
    };
  };
}
