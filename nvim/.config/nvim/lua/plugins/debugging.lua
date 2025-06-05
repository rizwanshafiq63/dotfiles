return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    local dap_status, dap = pcall(require, "dap")
    local dapui_status, dapui = pcall(require, "dapui")

    if not dap_status or not dapui_status then
      return
    end

    dapui.setup()

    -- Open DAP UI when debugging starts
    dap.listeners.before.attach.dapui_config = function() dapui.open() end
    dap.listeners.before.launch.dapui_config = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
    dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

    -- Keybindings
    vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {})
    vim.keymap.set("n", "<leader>dc", dap.continue, {})

    -- C++ (codelldb)
    if vim.fn.executable("codelldb") == 1 then
      dap.adapters.lldb = {
        type = "executable",
        command = "codelldb",
        name = "lldb",
      }

      dap.configurations.cpp = {
        {
          name = "Launch C++",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }

      -- Use same config for C
      dap.configurations.c = dap.configurations.cpp
    end

    -- Python (debugpy)
    if vim.fn.executable("python") == 1 then
      dap.adapters.python = {
        type = "executable",
        command = "python",
        args = { "-m", "debugpy.adapter" },
      }

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function() return "python" end,
        },
      }
    end

    -- Java (java-debug-adapter)
    if vim.fn.executable("java") == 1 then
      dap.adapters.java = {
        type = "server",
        host = "127.0.0.1",
        port = 5005,
      }

      dap.configurations.java = {
        {
          type = "java",
          request = "attach",
          name = "Attach to Java Process",
          hostName = "127.0.0.1",
          port = 5005,
        },
      }
    end

    -- Kotlin (java-debug-adapter for Kotlin)
    if vim.fn.executable("java") == 1 then
      dap.adapters.kotlin = {
        type = "server",
        host = "127.0.0.1",
        port = 5005,
      }

      dap.configurations.kotlin = {
        {
          type = "java",
          request = "launch",
          name = "Launch Kotlin Program",
          mainClass = function()
            return vim.fn.input('Main class (e.g., com.example.MainKt): ')
          end,
          projectName = function()
            return vim.fn.input('Project name (optional): ')
          end,
        },
      }
    end
  end,
}

