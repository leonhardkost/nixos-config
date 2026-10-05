{
  lib,
  config,
  ...
}:
{
  options.kekleo.neovim.typst.enable = lib.mkEnableOption "typst editing";

  config = {
    programs.nixvim = lib.mkIf config.kekleo.neovim.typst.enable {
      dependencies.tinymist.enable = true;
      dependencies.websocat.enable = true;

      plugins.typst-preview.enable = true;

      plugins.lsp.servers.tinymist.enable = true;
    };
  };
}
