reload "user.core.keymaps"
reload "user.core.options"
reload "user.core.telescope"
reload "user.core.lualine"
reload "user.plugins"

lvim.lsp.diagnostics.virtual_text = false

---@diagnostic disable-next-line: missing-parameter
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })

local formatters = require "lvim.lsp.null-ls.formatters"

formatters.setup {
  { command = "google_java_format", filetypes = { "java" } },
  { command = "stylua", filetypes = { "lua" } },
  { command = "shfmt", filetypes = { "sh", "zsh" } },
}
