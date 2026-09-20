{
  programs.nixvim = {
    diagnostic.settings = {
      severity_sort = true;
      float = {
        border = "rounded";
        source = "if_many";
      };
      signs.text.__raw = "{
        [vim.diagnostic.severity.ERROR] = '󰅚 ',
        [vim.diagnostic.severity.WARN] = '󰀪 ',
        [vim.diagnostic.severity.INFO] = '󰋽 ',
        [vim.diagnostic.severity.HINT] = '󰌶 ',
      }";
      virtual_text = {
        source = "if_many";
        spacing = 2;
        format.__raw = "
          function(diagnostic)
            return diagnostic.message
          end
        ";
      };
    };

    plugins = {
      lsp = {
        enable = true;

        keymaps = {
          silent = true;
          lspBuf = {
            "gd" = "definition";
            "gD" = "declaration";
            "gr" = "references";
            "gI" = "implementation";
            "<leader>ca" = "code_action";
            "<leader>D" = "type_definition";
            "<leader>rn" = "rename";
          };
        };

        servers = {
          lua_ls.enable = true;
          nil_ls.enable = true;
          basedpyright.enable = true;
          ts_ls.enable = true;
          vue_ls.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
          qmlls = {
            enable = true;
            cmd = [
              "qmlls"
              "-E"
            ];
          };
        };
      };
    };
  };
}
