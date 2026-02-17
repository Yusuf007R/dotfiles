return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = nil, -- handled by nvim-cmp
        clear_suggestion = "<C-]>",
        accept_word = "<C-j>",
      },
      disable_inline_completion = true, -- use nvim-cmp instead
      ignore_filetypes = {},
      color = {
        suggestion_color = "#999999",
        cterm = 244,
      },
      log_level = "info",
    })
  end,
}
