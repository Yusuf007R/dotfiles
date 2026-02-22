local themes = {
	"nyoom-engineering/oxocarbon.nvim",
	"catppuccin/nvim",
	"EdenEast/nightfox.nvim",
	"rose-pine/neovim",
	"olimorris/onedarkpro.nvim",
}
local active_theme = "EdenEast/nightfox.nvim"

local returnTable = {}
for i, v in ipairs(themes) do
	local is_active = v == active_theme
	table.insert(returnTable, {
		v,
		lazy = not is_active,
		priority = is_active and 1001 or (1000 - i),
	})
end

return returnTable
