return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  build = ":MasonUpdate",
  opts = {
    ui = {
      icons = {
        package_installed = "OK",
        package_pending = ">>",
        package_uninstalled = "XX",
      },
    },
  },
}
