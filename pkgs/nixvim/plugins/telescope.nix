{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ripgrep
  ];

  programs.nixvim.plugins.telescope = {
    enable = true;
    extensions.fzf-native.enable = true;
    keymaps = {
      "<leader>sh" = {
        action = "help_tags";
        options.desc = "Search Help";
      };
      "<leader>sf" = {
        action = "find_files";
        options.desc = "Search Files";
      };
      "<leader>ss" = {
        action = "builtin";
        options.desc = "Search Select Telescope";
      };
      "<leader>sg" = {
        action = "live_grep";
        options.desc = "Search by Grep";
      };
      "<leader><leader>" = {
        action = "buffers";
        options.desc = "Find existing buffers";
      };
      "<leader>/" = {
        action = "current_buffer_fuzzy_find";
        options.desc = "Find in current buffer";
      };
    };
    settings.defaults.file_ignore_patterns = [
      "^.git/"
      "^.mypy_cache/"
      "^__pycache__/"
      "^output/"
      "^data/"
      "^node_modules/"
      "%.ipynb"
    ];
  };
}
