return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    { "<leader>gb", "<cmd>Gitsigns blame_line<cr>", desc = "Blame line" },
    { "<leader>gh", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview hunk" },
    { "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset hunk" },
    { "]c", "<cmd>Gitsigns next_hunk<cr>", desc = "Next hunk" },
    { "[c", "<cmd>Gitsigns prev_hunk<cr>", desc = "Prev hunk" },
  },
  opts = {
    signs = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "▸" },
      topdelete = { text = "▾" },
      changedelete = { text = "┃" },
    },
  },
}
