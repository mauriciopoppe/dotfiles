local Utils = require("my.util")

return {
  -- snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    lazy = true,
  },

  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "rcarriga/cmp-dap",
      -- snippets
      "L3MON4D3/LuaSnip",
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
      -- snippet engine
      "saadparwaiz1/cmp_luasnip",
      -- icons
      "onsails/lspkind-nvim",
      -- suggestions
      {
        "jcdickinson/codeium.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "MunifTanjim/nui.nvim",
        },
        cond = function()
          return Utils.is_personal()
        end,
      },
      -- ml autocompletion (ciderlsp)
      {
        "piloto/cmp-nvim-ciderlsp",
        url = "sso://user/piloto/cmp-nvim-ciderlsp",
        cond = function()
          return Utils.is_google3()
        end,
      },
    },
    event = "InsertEnter",
    config = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      local sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip" },
        { name = "path" },
      }

      -- codeium isn't loaded at work so it's only conditionally loaded as a source
      if Utils.is_personal() and Utils.connected_to_internet() then
        require("codeium").setup({})
        table.insert(sources, #sources + 1, { name = "codeium" })
      end

      -- load ciderlsp completion
      if Utils.is_google3() then
        table.insert(sources, #sources + 1, { name = "nvim_ciderlsp" })
      end

      local function has_words_before()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local accept_current_item = cmp.mapping.confirm({ select = true })
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-y>"] = accept_current_item,
          ["<C-e>"] = cmp.mapping.abort(),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              accept_current_item(fallback)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources(
          sources,
          -- The buffer sources is only visible if there are no suggestions
          -- in the sources group
          { { name = "buffer", keyword_length = 3 } }
        ),
        formatting = {
          format = require("lspkind").cmp_format({
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            menu = {
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              nvim_ciderlsp = "[CiderLSP]",
              luasnip = "[LuaSnip]",
              nvim_lua = "[Lua]",
              latex_symbols = "[Latex]",
            },
          }),
        },
        experimental = {
          native_menu = false,
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype("gitcommit", {
        sources = {
          { name = "buffer" },
        },
      })

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
        sources = {
          { name = "dap" },
        },
      })
    end,
  },
}
