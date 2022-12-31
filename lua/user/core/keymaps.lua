M = {}

-- Set global key binding
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("", "<S-h>", "^", opts)
keymap("", "<S-l>", "$", opts)

-- recenter cursor after search
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)

keymap("n", "<esc><esc>", ":nohls<cr>", opts)

lvim.leader = "space"

-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":wa<cr>"
lvim.keys.normal_mode["<A-h>"] = "<Plug>(CybuNext)"
lvim.keys.normal_mode["<A-l>"] = "<Plug>(CybuPrev)"

lvim.keys.normal_mode["<C-t>"] = ":only<cr>"

-- remap lsp keymaps to use Telescope
lvim.lsp.buffer_mappings.normal_mode["gr"] = nil
lvim.lsp.buffer_mappings.normal_mode["gi"] = nil
lvim.lsp.buffer_mappings.normal_mode["gd"] = nil
lvim.lsp.buffer_mappings.normal_mode["gD"] = nil

lvim.lsp.buffer_mappings.normal_mode["gr"] = { ":Telescope lsp_references<CR>", "Goto References" }
lvim.lsp.buffer_mappings.normal_mode["gi"] = { ":Telescope lsp_implementations<CR>", "Goto Implementations" }
lvim.lsp.buffer_mappings.normal_mode["gd"] = { ":Telescope lsp_definitions<CR>", "Goto Definitions" }
lvim.lsp.buffer_mappings.normal_mode["gD"] = { ":Telescope lsp_type_definitions<CR>", "Goto Type Definitions" }

lvim.builtin.which_key.setup.plugins.registers = true
-- lvim.builtin.which_key.mappings["c"] = { "<cmd>BufferKill<CR>", "Close Buffer" }
lvim.builtin.which_key.mappings["q"] = { "<cmd>close<CR>", "Close window" }
lvim.builtin.which_key.mappings["Q"] = { "<cmd>lua require('lvim.utils.functions').smart_quit()<CR>", "Quit" }
-- lvim.builtin.which_key.mappings["q"] = nil
lvim.builtin.which_key.mappings["h"] = nil

lvim.builtin.which_key.mappings["d"] = {
	name = "Debug",
	b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
	c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
	i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
	o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
	O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
	r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
	l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
	u = { "<cmd>lua require'dapui'.toggle()<cr>", "UI" },
	x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
}

lvim.builtin.which_key.mappings["f"] = {
	name = "Find",
	b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
	c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
	f = { "<cmd>Telescope find_files<cr>", "Find files" },
	t = { "<cmd>Telescope live_grep<cr>", "Find Text" },
	s = { "<cmd>Telescope grep_string<cr>", "Find String" },
	h = { "<cmd>Telescope help_tags<cr>", "Help" },
	H = { "<cmd>Telescope highlights<cr>", "Highlights" },
	i = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Media" },
	l = { "<cmd>Telescope resume<cr>", "Last Search" },
	M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
	r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
	R = { "<cmd>Telescope registers<cr>", "Registers" },
	k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
	C = { "<cmd>Telescope commands<cr>", "Commands" },
}
lvim.builtin.which_key.mappings["g"] = {
	name = "Git",
	-- g = { "<cmd>lua require 'lvim.core.terminal'.lazygit_toggle(12000)<cr>", "Lazygit" },
	g = { "<cmd>Neogit<cr>", "Neogit" },
	j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
	k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
	l = { "<cmd>GitBlameToggle<cr>", "Blame" },
	p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
	r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
	R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
	s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
	u = {
		"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
		"Undo Stage Hunk",
	},
	n = { ":!git checkout -b ", "Checkout New Branch" },
	o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
	b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
	c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
	f = { "<cmd>Telescope git_bcommits<cr>", "Checkout buffer commit" },
	d = {
		"<cmd>Gitsigns diffthis HEAD<cr>",
		"Diff",
	},
	G = {
		name = "Gist",
		a = { "<cmd>Gist -b -a<cr>", "Create Anon" },
		d = { "<cmd>Gist -d<cr>", "Delete" },
		f = { "<cmd>Gist -f<cr>", "Fork" },
		g = { "<cmd>Gist -b<cr>", "Create" },
		l = { "<cmd>Gist -l<cr>", "List" },
		p = { "<cmd>Gist -b -p<cr>", "Create Private" },
	},
}
lvim.builtin.which_key.mappings["l"] = {
	name = "LSP",
	a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
	c = { "<cmd>lua require('copilot.suggestion').toggle_auto_trigger()<cr>", "Get Capabilities" },
	-- c = { "<cmd>lua require('user.lsp').server_capabilities()<cr>", "Get Capabilities" },
	d = { "<cmd>TroubleToggle<cr>", "Diagnostics" },
	w = {
		"<cmd>Telescope lsp_workspace_diagnostics<cr>",
		"Workspace Diagnostics",
	},
	f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
	F = { "<cmd>LspToggleAutoFormat<cr>", "Toggle Autoformat" },
	i = { "<cmd>LspInfo<cr>", "Info" },
	h = { "<cmd>lua require('lsp-inlayhints').toggle()<cr>", "Toggle Hints" },
	H = { "<cmd>IlluminationToggle<cr>", "Toggle Doc HL" },
	I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
	j = {
		"<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>",
		"Next Diagnostic",
	},
	k = {
		"<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
		"Prev Diagnostic",
	},
	v = { "<cmd>lua require('lsp_lines').toggle()<cr>", "Virtual Text" },
	l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
	o = { "<cmd>SymbolsOutline<cr>", "Outline" },
	q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
	r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
	R = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
	s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
	S = {
		"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
		"Workspace Symbols",
	},
	t = { '<cmd>lua require("user.functions").toggle_diagnostics()<cr>', "Toggle Diagnostics" },
	u = { "<cmd>LuaSnipUnlinkCurrent<cr>", "Unlink Snippet" },
}

lvim.builtin.which_key.mappings["t"] = {
	name = "Tab",
	t = {
		"<cmd>lua require('telescope').extensions['telescope-tabs'].list_tabs(require('telescope.themes').get_dropdown{previewer = false, initial_mode='normal', prompt_title='Tabs'})<cr>",
		"Find Tab",
	},
	n = { "<cmd>tabnew %<cr>", "New Tab" },
	c = { "<cmd>tabclose<cr>", "Close Tab" },
	o = { "<cmd>tabonly<cr>", "Only Tab" },
}
-- lvim.builtin.cmp.enabled = false
lvim.builtin.which_key.mappings["o"] = {
	name = "Options",
	c = { "<cmd>lua lvim.builtin.cmp.active = false<cr>", "Completion off" },
	C = { "<cmd>lua lvim.builtin.cmp.active = true<cr>", "Completion on" },
	w = { '<cmd>lua require("user.functions").toggle_option("wrap")<cr>', "Wrap" },
	r = { '<cmd>lua require("user.functions").toggle_option("relativenumber")<cr>', "Relative" },
	l = { '<cmd>lua require("user.functions").toggle_option("cursorline")<cr>', "Cursorline" },
	-- s = { '<cmd>lua require("user.functions").toggle_option("spell")<cr>', "Spell" },
	t = { '<cmd>lua require("user.functions").toggle_tabline()<cr>', "Tabline" },
}

lvim.builtin.which_key.mappings[";"] = nil
lvim.builtin.which_key.mappings["c"] = nil
lvim.builtin.which_key.mappings["L"] = nil
lvim.builtin.which_key.mappings["s"] = nil
lvim.builtin.which_key.mappings["w"] = nil
