return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup()

    local parsers = {
      "typescript",
      "javascript",
      "tsx",
      "html",
      "css",
      "json",
      "rust",
      "java",
      "lua",
      "bash",
      "markdown",
      "markdown_inline",
      "regex",
      "yaml",
    }
    require("nvim-treesitter").install(parsers)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",
      callback = function()
        pcall(function()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end)
      end,
    })
  end,
}
