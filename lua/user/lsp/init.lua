local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "user.lsp.lsp-installer"
require("user.lsp.handlers").setup()
require "user.lsp.null-ls"

--[[
-- require("lspconfig").tsserver.setup {}
-- require("lspconfig").pyright.setup {}
-- require("lspconfig").sumneko_lua.setup {}

local nvim_lsp = require('lspconfig')
local servers = { 'tsserver', 'pyright', 'sumneko_lua'}

local on_attach = function (client, bufnr)
  -- Use an on_attach function to only map the following keys after 
  -- the language server attaches to the current buffer
end

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach
  }
end
]]
