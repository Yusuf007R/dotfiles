return {
	{
		"saghen/blink.cmp",
		version = "1.*",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"rafamadriz/friendly-snippets",
			"giuxtaposition/blink-cmp-copilot",
			"Exafunction/windsurf.nvim",
		},
		opts = {
			keymap = {
				preset = "default",
				["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
				["<Tab>"] = { "accept", "fallback" },
			},
			completion = {
				ghost_text = { enabled = true },
				documentation = { auto_show = true },
			},
			snippets = {
				preset = "luasnip",
			},
			sources = {
				default = { "codeium", "copilot", "lsp", "snippets", "buffer", "path" },
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-cmp-copilot",
						score_offset = 100,
						async = true,
						min_keyword_length = function(ctx)
							return ctx.trigger.kind == "trigger_character" or ctx.trigger.kind == "manual" and 0 or 1
						end,
					},
					codeium = {
						name = "Codeium",
						module = "codeium.blink",
						score_offset = 110,
						async = true,
						min_keyword_length = function(ctx)
							return ctx.trigger.kind == "trigger_character" or ctx.trigger.kind == "manual" and 0 or 1
						end,
					},
				},
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}
