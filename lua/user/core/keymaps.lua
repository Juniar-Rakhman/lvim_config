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
lvim.keys.normal_mode["<A-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<A-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<C-t>"] = ":only<cr>"


lvim.builtin.which_key.mappings["c"] = { "<cmd>close<CR>", "Close window" }
lvim.builtin.which_key.mappings["q"] = { "<cmd>BufferKill<CR>", "Close Buffer" }
lvim.builtin.which_key.mappings["Q"] = { "<cmd>lua require('lvim.utils.functions').smart_quit()<CR>", "Quit" }
-- remap lsp keymaps to Telescope
lvim.lsp.buffer_mappings.normal_mode["gr"] = { ":Telescope lsp_references<CR>", "Goto References" }
lvim.lsp.buffer_mappings.normal_mode["gi"] = { ":Telescope lsp_implementations<CR>", "Goto Implementations" }
lvim.lsp.buffer_mappings.normal_mode["gd"] = { ":Telescope lsp_definitions<CR>", "Goto Definitions" }
lvim.lsp.buffer_mappings.normal_mode["gD"] = { ":Telescope lsp_type_definitions<CR>", "Goto Type Definitions" }

-- lvim.builtin.which_key.mappings["q"] = nil
lvim.builtin.which_key.mappings["h"] = nil

return M
