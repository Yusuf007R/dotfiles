return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local fzf = require("fzf-lua")

			-- fzf.setup({
			-- 	{ "telescope" }, -- Telescope-like look and feel
			-- })

			fzf.register_ui_select()

			vim.keymap.set("n", "<leader>ff", function()
				fzf.files()
			end, { desc = "Find files" })

			vim.keymap.set("n", "<leader>fa", function()
				fzf.files({ no_ignore = true, hidden = true })
			end, { desc = "Find files including gitignored and hidden" })

			vim.keymap.set("n", "<leader>fb", function()
				fzf.buffers()
			end, { desc = "Find Buffers" })

			vim.keymap.set("n", "<leader>fg", function()
				fzf.live_grep()
			end, { desc = "Find Live grep" })

			vim.keymap.set("n", "<leader>fr", function()
				fzf.oldfiles()
			end, { desc = "Find Old files" })

			vim.keymap.set("n", "<leader>ft", function()
				fzf.colorschemes()
			end, { desc = "Theme Switcher" })

			vim.keymap.set("n", "<leader>fp", function()
				fzf.zoxide()
			end, { desc = "Find Project/Directory" })

			vim.keymap.set("n", "<leader>fh", function()
				fzf.helptags()
			end, { desc = "Find Help tags" })

			vim.keymap.set("n", "<leader>fk", function()
				fzf.keymaps()
			end, { desc = "Find Keymaps" })

			vim.keymap.set("n", "<leader>fo", function()
				fzf.lsp_document_symbols()
			end, { desc = "Find Methods in file" })
		end,
	},
}
