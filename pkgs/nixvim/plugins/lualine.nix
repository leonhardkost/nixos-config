{
  plugins.lualine = {
    enable = true;
    settings = {
      options = {
        section_separators = "";
        component_separators = "";
      };
      sections = {
        lualine_b = [
          {
            __unkeyed-1 = "branch";
            icon = "";
          }
        ];
        lualine_c = [ "filename" ];
        lualine_x = [ "filetype" ];
      };
    };
  };
}
