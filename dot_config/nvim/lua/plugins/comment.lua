return {
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
  },
  {
    "numToStr/Comment.nvim",
    lazy = false,
    config = function()
      vim.keymap.set('n', '<leader>/', "<Plug>(comment_toggle_linewise_current)", {desc = 'Comment'})
      vim.keymap.set('v', '<leader>/', "<Plug>(comment_toggle_linewise_visual)", {desc = 'Comment'})

      require("Comment").setup()
    end
  },
}
