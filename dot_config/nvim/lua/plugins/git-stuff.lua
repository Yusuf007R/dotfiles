return {
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Git diff" },
      { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Close git diff" },
      { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "Git file history" },
      { "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "Git current file history" },
      { "<leader>gf", "<cmd>DiffviewToggleFiles<cr>", desc = "Toggle git files panel" },
      { "<leader>gr", "<cmd>DiffviewRefresh<cr>", desc = "Refresh git diff" },
    },
    config = function()
      local actions = require("diffview.actions")
      require("diffview").setup({
        view = {
          default = {
            layout = "diff2_horizontal",
          },
          merge_tool = {
            layout = "diff3_horizontal",
          },
        },
        keymaps = {
          view = {
            { "n", "<leader>e", actions.focus_files, { desc = "Focus file panel" } },
            { "n", "<leader>b", actions.toggle_files, { desc = "Toggle file panel" } },
            { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
          },
          file_panel = {
            { "n", "<leader>e", actions.focus_files, { desc = "Focus file panel" } },
            { "n", "<leader>b", actions.toggle_files, { desc = "Toggle file panel" } },
            { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
          },
        },
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()

      vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Git preview hunk" })
      vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>",
        { desc = "Git toggle current line blame" })
    end
  }
}
