return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-project.nvim", "andrew-george/telescope-themes" },
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
          ['themes'] = {},
          ['project'] = {}
        },
      })
      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find Live grep" })
      vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Find Old files" })
      vim.keymap.set("n", "<leader>ft", ":Telescope themes<CR>",
        { noremap = true, silent = true, desc = "Theme Switcher" })
      vim.keymap.set("n", "<leader>fp", ":Telescope project<CR>",
        { desc = "Find Project" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags,
        { desc = "Find Help tags" })
      vim.keymap.set("n", "<leader>fk", builtin.keymaps,
        { desc = "Find Keymaps" })
      vim.keymap.set("n", "<leader>fo", builtin.lsp_document_symbols, { desc = "Find Methods in file" })
    end,
  },
}
