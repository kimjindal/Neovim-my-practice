local status_ok, flutter_tools = pcall(require, "flutter-tools")
if not status_ok then
  return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

flutter_tools.setup {
  ui = {
    border = "rounded",
  },
  decorations = {
    statusline = {
      app_version = false,
      device = false,
    },
  },
  debugger = {
    enabled = false,
    run_via_dap = false,
  },
  flutter_lookup_cmd = nil,
  fvm = false,
  widget_guides = {
    enabled = false,
  },
  closing_tags = {
    highlight = "ErrorMsg",
    prefix = ">",
    enabled = true,
  },
  dev_log = {
    enabled = true,
    open_cmd = "tabedit",
  },
  dev_tools = {
    autostart = false,
    auto_open_browser = false,
  },
  outline = {
    open_cmd = "30vnew",
    auto_open = false,
  },
  lsp = {
    capabilities = capabilities,
  },
}
