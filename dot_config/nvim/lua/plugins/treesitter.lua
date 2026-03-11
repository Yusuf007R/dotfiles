return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local parsers = {
				"typescript",
				"tsx",
				"javascript",
				"jsdoc",
				"html",
				"css",
				"scss",
				"json",
				"json5",
				"rust",
				"java",
				"dart",
				"c_sharp",
				"c",
				"cpp",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
				"dockerfile",
				"yaml",
				"toml",
				"xml",
				"bash",
				"fish",
				"git_config",
				"git_rebase",
				"gitcommit",
				"gitignore",
				"diff",
				"regex",
				"comment",
				"sql",
				"python",
				"go",
				"make",
				"cmake",
				"php",
				"ruby",
				"graphql",
				"http",
				"kotlin",
				"swift",
			}

			require("nvim-treesitter").install(parsers):wait(300000)

			local ts_group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				group = ts_group,
				pattern = "*",
				callback = function(args)
					local ok = pcall(vim.treesitter.start, args.buf)
					if ok then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
}
