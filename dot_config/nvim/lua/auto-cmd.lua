vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('UserColorScheme', {}),
  callback = function()
    require('custom-alpha-banner')(require("alpha.themes.dashboard"))
    require("lualine").setup({})
  end
})
