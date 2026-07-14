return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<C-n>", "<cmd>Neotree toggle<cr>", desc = "Toggle file tree" },
    { "<leader>bf", "<cmd>Neotree reveal<cr>", desc = "Reveal in file tree" },
  },
  opts = {
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_hidden = false,
      },
      follow_current_file = { enabled = true },
    },
    window = {
      width = 35,
    },
  },
}
