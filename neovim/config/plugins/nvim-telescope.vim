nnoremap <silent> [ui]f :<C-u>Telescope live_grep<CR>
nnoremap <silent> [ui]b :<C-u>Telescope buffers<CR>
nnoremap <silent> [ui]o :<C-u>Telescope find_files<CR>
nnoremap <silent> [ui]r :<C-u>Telescope resume<CR>
nnoremap <silent> [ui]l :<C-u>Telescope current_buffer_fuzzy_find<CR>
nnoremap <silent> [ui]w :<C-u>Telescope grep_string<CR>
nnoremap <silent> [ui]q :<C-u>Telescope quickfix<CR>

nnoremap <silent> <leader>a :<C-u>Telescope lsp_code_actions<CR>
nnoremap <silent> <leader>d :<C-u>Telescope lsp_definitions<CR>
nnoremap <silent> <leader>t :<C-u>Telescope lsp_type_definitions<CR>
nnoremap <silent> <leader>i :<C-u>Telescope lsp_implementations<CR>
nnoremap <silent> <leader>r :<C-u>Telescope lsp_references<CR>

lua << EOF
local actions = require("telescope.actions")
local split_vertical_theme = {
  theme = "dropdown",
  layout_config = {
    preview_cutoff = 1,
    width = function(_, max_columns, _)
      return math.min(max_columns, 180)
    end,
    height = function(_, _, max_lines)
      return math.min(max_lines, 30)
    end,
  },
}

require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-c>"] = actions.close
      },
    },
  },
  pickers = {
    find_files = {
      find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
    },
    lsp_references = split_vertical_theme,
    lsp_implementations = split_vertical_theme,
  }
}
EOF
