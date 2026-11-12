{
  programs.nixvim = {
    plugins.dap = {
      enable = true;
      luaConfig.content = ''
        local dap = require 'dap'
        local dapui = require 'dapui'
        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close
      '';
    };
    plugins.dap-ui.enable = true;
    plugins.dap-python.enable = true;
    keymaps = [
      {
        mode = "n";
        key = "<F5>";
        action = "<cmd>DapContinue<CR>";
        options.desc = "Debug: Start/Continue";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<F1>";
        action = "<cmd>DapStepInto<CR>";
        options.desc = "Debug: Step Into";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<F2>";
        action = "<cmd>DapStepOver<CR>";
        options.desc = "Debug: Step Over";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<F3>";
        action = "<cmd>DapStepOut<CR>";
        options.desc = "Debug: Step Out";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>b";
        action = "<cmd>DapToggleBreakpoint<CR>";
        options.desc = "Debug: Toggle Breakpoint";
        options.silent = true;
      }
    ];
  };
}
