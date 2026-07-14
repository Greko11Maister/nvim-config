return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    require("mason").setup()

    require("mason-lspconfig").setup({
      ensure_installed = {
        "ts_ls",
        "angularls",
        "jdtls",
        "rust_analyzer",
        "lua_ls",
        "html",
        "cssls",
        "jsonls",
      },
    })

    require("mason-tool-installer").setup({
      ensure_installed = {
        "eslint_d",
        "prettierd",
        "stylua",
        "google-java-format",
      },
      auto_update = false,
      run_on_start = true,
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, desc = "LSP" }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
      end,
    })

    vim.lsp.config("ts_ls", {})
    vim.lsp.enable("ts_ls")

    vim.lsp.config("angularls", {})
    vim.lsp.enable("angularls")

    vim.lsp.config("rust_analyzer", {
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = true,
        },
      },
    })
    vim.lsp.enable("rust_analyzer")

    vim.lsp.config("jdtls", {})
    vim.lsp.enable("jdtls")

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
        },
      },
    })
    vim.lsp.enable("lua_ls")

    vim.lsp.config("html", {})
    vim.lsp.enable("html")

    vim.lsp.config("cssls", {})
    vim.lsp.enable("cssls")

    vim.lsp.config("jsonls", {})
    vim.lsp.enable("jsonls")
  end,
}
