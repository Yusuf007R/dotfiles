return {
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open diffview" },
			{ "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
		},
		config = function()
			local actions = require("diffview.actions")

			require("diffview").setup({
				enhanced_diff_hl = true,
				show_help_hints = false,
				view = {
					default = {
						layout = "diff2_horizontal",
					},
					merge_tool = {
						layout = "diff3_horizontal",
					},
				},
				file_panel = {
					win_config = {
						width = 30,
					},
				},
				keymaps = {
					view = {
						{ "n", "q", actions.close, { desc = "Close" } },
					},
					file_panel = {
						{ "n", "q", actions.close, { desc = "Close" } },
					},
				},
			})

			vim.opt.diffopt = "internal,filler,closeoff,context:3,algorithm:histogram,linematch:60"
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gs = require("gitsigns")

			gs.setup({
				current_line_blame = false,
				word_diff = false,
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
			})

			vim.keymap.set("n", "]h", function()
				gs.nav_hunk("next")
			end, { desc = "Next hunk" })
			vim.keymap.set("n", "[h", function()
				gs.nav_hunk("prev")
			end, { desc = "Prev hunk" })
			vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
			vim.keymap.set("n", "<leader>gs", gs.stage_hunk, { desc = "Stage hunk" })
			vim.keymap.set("n", "<leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
			vim.keymap.set("n", "<leader>gb", gs.toggle_current_line_blame, { desc = "Toggle blame" })
		end,
	},
}
