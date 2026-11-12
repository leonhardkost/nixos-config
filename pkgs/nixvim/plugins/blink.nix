{
  programs.nixvim = {
    plugins = {
      blink-indent.enable = true;
      blink-pairs.enable = true;
      blink-cmp = {
        enable = true;
        settings = {
          signature.enabled = true;
          keymap = {
            preset = "default";
            "<CR>" = [
              "accept"
              "fallback"
            ];
          };
        };
      };
    };
  };
}
