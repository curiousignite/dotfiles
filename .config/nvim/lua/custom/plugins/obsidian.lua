return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },
  opts = {
    ui = {
      enable = true,
    },
    workspaces = {
      {
        name = "Vault",
        path = "~/Vault",
      },
    },
  },
}
