nnoremap <silent> [ui]f :<C-u>Telescope live_grep<CR>
nnoremap <silent> [ui]b :<C-u>Telescope buffers<CR>
nnoremap <silent> [ui]o :<C-u>Telescope find_files<CR>
nnoremap <silent> [ui]r :<C-u>Telescope resume<CR>
nnoremap <silent> [ui]l :<C-u>Telescope current_buffer_fuzzy_find<CR>
nnoremap <silent> [ui]w :<C-u>Telescope grep_string<CR>
nnoremap <silent> [ui]q :<C-u>Telescope quickfix<CR>

lua << EOF
local actions = require("telescope.actions")
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
      find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }
    },
  }
}
EOF
