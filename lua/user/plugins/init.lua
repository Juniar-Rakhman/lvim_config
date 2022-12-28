-- Additional Plugins
lvim.plugins = {
  "leoluz/nvim-dap-go",
  "LukasPietzschmann/telescope-tabs",
  { "chaoren/vim-wordmotion",
    fn = { "<Plug>WordMotion_w" }
  },
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
}
