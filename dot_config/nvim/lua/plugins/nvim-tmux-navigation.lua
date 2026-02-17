return {
  "alexghergh/nvim-tmux-navigation",
  config = function()
    require('nvim-tmux-navigation').setup({})
    vim.keymap.set("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", { desc = "Move to pane left" })
    vim.keymap.set("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", { desc = "Move to pane below" })
    vim.keymap.set("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", { desc = "Move to pane above" })
    vim.keymap.set("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", { desc = "Move to pane right" })
  end,
}
