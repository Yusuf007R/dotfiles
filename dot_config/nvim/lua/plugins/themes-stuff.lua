local themes = { 'nyoom-engineering/oxocarbon.nvim', 'catppuccin/nvim', 'EdenEast/nightfox.nvim', 'rose-pine/neovim' }

local returnTable = {}
for i, v in ipairs(themes) do
  table.insert(returnTable, {
    v,
    lazy = false,
    priority = 1000 - i
  })
end

-- manually adding onedark because it needs custom config

table.insert(returnTable, {
  'olimorris/onedarkpro.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require("onedarkpro").setup({
      colors = {
        onedark = { bg = "#1f2329" },
      }
    })
  end
})
return returnTable
