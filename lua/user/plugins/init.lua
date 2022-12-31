-- disabled core plugins list ---
lvim.builtin.lir.active = false
lvim.builtin.bufferline.active = false

----------------------------

-- Additional Plugins
lvim.plugins = {
	"windwp/nvim-ts-autotag",
	"p00f/nvim-ts-rainbow",
	"LukasPietzschmann/telescope-tabs",
	{ "chaoren/vim-wordmotion", fn = { "<Plug>WordMotion_w" } },
	"David-Kunz/markid", -- Better syntax highlighting
	{
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function()
			require("lsp_signature").setup()
		end,
	},
	{
		"phaazon/hop.nvim",
		event = "BufRead",
		config = function()
			require("hop").setup()
			vim.api.nvim_set_keymap("n", "f", ":HopChar2<cr>", { silent = true })
			vim.api.nvim_set_keymap("n", "F", ":HopWord<cr>", { silent = true })
		end,
	},
	-- lsp related
	"leoluz/nvim-dap-go",
	"mfussenegger/nvim-jdtls",
	{
		"ghillb/cybu.nvim",
		-- branch = "main", -- timely updates
		branch = "v1.x", -- won't receive breaking changes
		requires = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" }, -- optional for icon support
		config = function()
			require("user.plugins.cybu").setup()
		end,
	},
}
