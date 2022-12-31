reload("user.plugins")
reload("user.functions")

-- Core functionalities
reload("user.core.autocmds")
reload("user.core.colorscheme")
reload("user.core.inlay-hints")
reload("user.core.keymaps")
reload("user.core.lualine")
reload("user.core.nvimtree")
reload("user.core.options")
reload("user.core.telescope")
reload("user.core.treesitter")

lvim.lsp.diagnostics.virtual_text = false

---@diagnostic disable-next-line: missing-parameter
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })

local formatters = require("lvim.lsp.null-ls.formatters")

formatters.setup({
	-- { command = "google_java_format", filetypes = { "java" } },
	{ command = "stylua", filetypes = { "lua" } },
	{ command = "shfmt", filetypes = { "sh", "zsh" } },
})
