{
  programs.nixvim.opts = {
    number = true;
    relativenumber = true;
    showmode = false;

    breakindent = true;

    undofile = true;

    ignorecase = true;
    smartcase = true;

    signcolumn = "yes";

    updatetime = 250;
    timeoutlen = 300;

    splitright = true;
    splitbelow = true;

    list = true;
    listchars = {
      tab = "» ";
      trail = "·";
      nbsp = "␣";
    };

    inccommand = "split";

    cursorline = true;

    scrolloff = 10;

    confirm = true;
  };
}
