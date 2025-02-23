local Utils = require("my.util")

return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "[ui]cc", ":CodeCompanionChat<CR>", silent = true },
      { "[ui]ci", ":CodeCompanion ", silent = true },
    },
    cond = function()
      return Utils.is_personal()
    end,
    config = function()
      require("codecompanion").setup({
        adapters = {
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              schema = {
                model = {
                  default = "deepseek-r1",
                },
              },
            })
          end,
        },
        strategies = {
          chat = {
            adapter = "ollama",
            keymaps = {
              send = {
                modes = { n = "<C-s>", i = "<C-s>" },
              },
              close = {
                modes = { n = "Q", i = "<leader>w" },
              },
            },
          },
          inline = {
            adapter = "ollama",
          },
        },
      })
    end,
  },
}
