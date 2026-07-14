return {
  "mfussenegger/nvim-dap",
  lazy = false,
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      dependencies = {
        "nvim-neotest/nvim-nio",
      },
    },
    "jay-babu/mason-nvim-dap.nvim",
    "williamboman/mason.nvim",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- Breakpoint signs
    vim.fn.sign_define("DapBreakpoint", {
      text = "●",
      texthl = "DapBreakpoint",
      linehl = "",
      numhl = "",
    })
    vim.fn.sign_define("DapBreakpointCondition", {
      text = "●",
      texthl = "DapBreakpointCondition",
      linehl = "",
      numhl = "",
    })
    vim.fn.sign_define("DapLogPoint", {
      text = "◆",
      texthl = "DapLogPoint",
      linehl = "",
      numhl = "",
    })
    vim.fn.sign_define("DapStopped", {
      text = "▶",
      texthl = "DapStopped",
      linehl = "DapStopped",
      numhl = "",
    })

    -- Auto-install debug adapters via Mason
    require("mason-nvim-dap").setup({
      ensure_installed = { "js-debug-adapter", "codelldb", "java-debug-adapter" },
    })

    -- DAP UI
    dapui.setup()

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- ============================================================
    -- Keymaps
    -- ============================================================
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
    vim.keymap.set("n", "<leader>dB", function()
      dap.set_breakpoint(vim.fn.input("Condition: "))
    end, { desc = "Conditional breakpoint" })
    vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
    vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
    vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
    vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "Step out" })
    vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
    vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate session" })
    vim.keymap.set("n", "<leader>dui", dapui.toggle, { desc = "Toggle DAP UI" })
    vim.keymap.set("n", "<leader>dl", function()
      dap.run_last()
    end, { desc = "Run last" })
    vim.keymap.set("v", "<leader>de", function()
      dapui.eval()
    end, { desc = "Evaluate selection" })
    vim.keymap.set("n", "<leader>de", function()
      dapui.eval(nil, { enter = true })
    end, { desc = "Evaluate expression" })

    -- ============================================================
    -- Helper: get Mason package install path
    -- ============================================================
    local function mason_install_path(pkg)
      local ok, pkg_ent = pcall(require("mason-registry").get_package, pkg)
      return ok and pkg_ent:get_install_path() or nil
    end

    -- ============================================================
    -- Adapters
    -- ============================================================

    -- js-debug-adapter → pwa-node (Node.js / NestJS) + pwa-chrome (Angular)
    dap.adapters["pwa-node"] = function(cb, config)
      local adapter_path = mason_install_path("js-debug-adapter")
      if not adapter_path then
        vim.notify("js-debug-adapter not installed. Run :Mason", vim.log.levels.ERROR)
        return
      end
      local port = config.port or 8123
      cb({
        type = "server",
        host = "localhost",
        port = port,
        executable = {
          command = "node",
          args = { adapter_path .. "/js-debug/src/dapDebugServer.js", tostring(port) },
        },
      })
    end

    dap.adapters["pwa-chrome"] = function(cb, config)
      local adapter_path = mason_install_path("js-debug-adapter")
      if not adapter_path then
        vim.notify("js-debug-adapter not installed. Run :Mason", vim.log.levels.ERROR)
        return
      end
      local port = config.port or 9229
      cb({
        type = "server",
        host = "localhost",
        port = port,
        executable = {
          command = "node",
          args = { adapter_path .. "/js-debug/src/dapDebugServer.js", tostring(port) },
        },
      })
    end

    -- codelldb → Rust
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
      },
    }

    -- java-debug-adapter → Java
    dap.adapters.java = {
      type = "executable",
      command = "java-debug-adapter",
    }

    -- ============================================================
    -- Configurations per language
    -- ============================================================

    -- NestJS / Node (TypeScript backend)
    dap.configurations.typescript = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug NestJS (ts-node main.ts)",
        program = "${workspaceFolder}/src/main.ts",
        cwd = "${workspaceFolder}",
        sourceMaps = true,
        runtimeArgs = { "--nolazy", "-r", "ts-node/register" },
        env = { NODE_ENV = "development" },
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach to Node process",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
        sourceMaps = true,
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug current file (Node)",
        program = "${file}",
        cwd = "${workspaceFolder}",
        sourceMaps = true,
        runtimeArgs = { "--nolazy" },
      },
    }
    dap.configurations.javascript = dap.configurations.typescript

    -- Angular frontend (attach to Chrome)
    dap.configurations.typescriptreact = {
      {
        type = "pwa-chrome",
        request = "launch",
        name = "Launch Angular (Chrome)",
        url = "http://localhost:4200",
        webRoot = "${workspaceFolder}",
        sourceMapPathOverrides = {
          ["webpack://./*"] = "${webRoot}/*",
          ["webpack:///./*"] = "${webRoot}/*",
          ["webpack:///*"] = "${webRoot}/*",
        },
        runtimeArgs = { "--remote-debugging-port=9222" },
      },
      {
        type = "pwa-chrome",
        request = "attach",
        name = "Attach to Angular (Chrome :9222)",
        port = 9222,
        urlFilter = "http://localhost:4200/*",
        webRoot = "${workspaceFolder}",
        sourceMapPathOverrides = {
          ["webpack://./*"] = "${webRoot}/*",
          ["webpack:///./*"] = "${webRoot}/*",
          ["webpack:///*"] = "${webRoot}/*",
        },
      },
    }

    -- Rust
    dap.configurations.rust = {
      {
        name = "Launch Rust binary",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to binary: ", vim.fn.getcwd() .. "/target/debug/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }

    -- Java
    dap.configurations.java = {
      {
        type = "java",
        request = "launch",
        name = "Launch Java file",
        mainClass = function()
          return vim.fn.input("Main class: ", "", "file")
        end,
        projectName = "${workspaceFolder}",
      },
      {
        type = "java",
        request = "attach",
        name = "Attach to JVM (port 5005)",
        hostName = "localhost",
        port = 5005,
      },
    }
  end,
}
