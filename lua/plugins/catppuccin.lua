return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "mocha",
    transparent_background = false,
    integrations = {
      telescope = true,
      treesitter = true,
      neo_tree = true,
      cmp = true,
      gitsigns = true,
      mason = true,
      which_key = true,
      dap = true,
      dap_ui = true,
      toggleterm = true,
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
