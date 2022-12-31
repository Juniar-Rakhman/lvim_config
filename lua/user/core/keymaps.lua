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

return M
