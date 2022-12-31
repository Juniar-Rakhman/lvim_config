lvim.builtin.telescope.defaults.file_ignore_patterns = {
	".git/",
	"target/",
	"docs/",
	"vendor/*",
	"%.lock",
	"__pycache__/*",
	"%.sqlite3",
	"%.ipynb",
	"node_modules/*",
	-- "%.jpg",
	-- "%.jpeg",
	-- "%.png",
	"%.svg",
	"%.otf",
	"%.ttf",
	"%.webp",
	".dart_tool/",
	".github/",
	".gradle/",
	".idea/",
	".settings/",
	".vscode/",
	"__pycache__/",
	"build/",
	"env/",
	"gradle/",
	"node_modules/",
	"%.pdb",
	"%.dll",
	"%.class",
	"%.exe",
	"%.cache",
	"%.ico",
	"%.pdf",
	"%.dylib",
	"%.jar",
	"%.docx",
	"%.met",
	"smalljre_*/*",
	".vale/",
	"%.burp",
	"%.mp4",
	"%.mkv",
	"%.rar",
	"%.zip",
	"%.7z",
	"%.tar",
	"%.bz2",
	"%.epub",
	"%.flac",
	"%.tar.gz",
}
local _, actions = pcall(require, "telescope.actions")

lvim.builtin.telescope.defaults.mappings = {
	-- for input mode
	i = {
		["<C-n>"] = actions.cycle_history_next,
		["<C-p>"] = actions.cycle_history_prev,

		["<C-j>"] = actions.move_selection_next,
		["<C-k>"] = actions.move_selection_previous,

		["<C-b>"] = actions.results_scrolling_up,
		["<C-f>"] = actions.results_scrolling_down,

		["<C-c>"] = actions.close,

		["<Down>"] = actions.move_selection_next,
		["<Up>"] = actions.move_selection_previous,

		["<CR>"] = actions.select_default,
		["<C-s>"] = actions.select_horizontal,
		["<C-v>"] = actions.select_vertical,
		["<C-t>"] = actions.select_tab,

		["<c-d>"] = require("telescope.actions").delete_buffer,
		["<Tab>"] = actions.close,

		["<S-Tab>"] = actions.close,

		["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
		["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
		["<C-l>"] = actions.complete_tag,
		["<C-h>"] = actions.which_key,
		-- ["<esc>"] = actions.close,
	},
	-- for normal mode
	n = {
		-- ["<esc>"] = actions.close,
		["<CR>"] = actions.select_default,
		["<C-x>"] = actions.select_horizontal,
		["<C-v>"] = actions.select_vertical,
		["<C-t>"] = actions.select_tab,
		["<C-b>"] = actions.results_scrolling_up,
		["<C-f>"] = actions.results_scrolling_down,

		["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
		["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

		["j"] = actions.move_selection_next,
		["k"] = actions.move_selection_previous,
		["H"] = actions.move_to_top,
		["M"] = actions.move_to_middle,
		["L"] = actions.move_to_bottom,
		["q"] = actions.close,
		["dd"] = require("telescope.actions").delete_buffer,
		["s"] = actions.select_horizontal,
		["v"] = actions.select_vertical,
		["t"] = actions.select_tab,

		["<Down>"] = actions.move_selection_next,
		["<Up>"] = actions.move_selection_previous,
		["gg"] = actions.move_to_top,
		["G"] = actions.move_to_bottom,

		["<C-u>"] = actions.preview_scrolling_up,
		["<C-d>"] = actions.preview_scrolling_down,

		["<PageUp>"] = actions.results_scrolling_up,
		["<PageDown>"] = actions.results_scrolling_down,

		["?"] = actions.which_key,
	},
}

local default_layout = {
	preview = true,
	theme = "dropdown",
	layout_strategies = "vertical",
	layout_config = {
		vertical = {
			results_height = 0.6,
			preview_height = 0.7,
		},
		width = 0.87,
	},
}

lvim.builtin.telescope.pickers.live_grep = default_layout
lvim.builtin.telescope.pickers.lsp_references = default_layout
lvim.builtin.telescope.pickers.lsp_declarations = default_layout
lvim.builtin.telescope.pickers.lsp_definitions = default_layout
lvim.builtin.telescope.pickers.lsp_implementations = default_layout
lvim.builtin.telescope.pickers.buffers = default_layout
lvim.builtin.telescope.pickers.grep_string = default_layout
lvim.builtin.telescope.pickers.old_files = default_layout

lvim.builtin.telescope.pickers.find_files = {
	theme = "dropdown",
	previewer = false,
	initial_mode = "insert",
}

lvim.builtin.telescope.pickers.colorscheme = {
	enable_preview = true,
}
