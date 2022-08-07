" https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
" https://github.com/neovim/nvim-lspconfig
lua <<EOF

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
end

-- Checks if a path is a file.
function is_file(path)
    f = io.open(path)
    return f ~= nil
end

-- Checks if a path is a directory.
-- From https://stackoverflow.com/questions/2833675/using-lua-check-if-file-is-a-directory
function is_dir(path)
    f = io.open(path)
    return not f:read(0) and f:seek("end") ~= 0
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities
}

-- assume that there's a file BUILD in google 3 repos.
-- the check makes sure that gopls is enabled only in non google3 repos.
local is_google3 = is_file('BUILD') and not is_dir('BUILD')
if not is_google3 then
  nvim_lsp.gopls.setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = capabilities
  }
end

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
require'lspconfig'.sumneko_lua.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

EOF
