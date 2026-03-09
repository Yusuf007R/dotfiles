local map = vim.keymap.set


map({ 'n', 'i', 'v' }, '<C-s>', '<cmd>:w<CR>')

map('n', '<leader>ln', function()
  vim.wo.relativenumber = not vim.wo.relativenumber
end, {
  desc = "Toggle relative number"
})


map('n', '<leader>cl', function()
  vim.o.cursorline = not vim.o.cursorline
end, {
  desc = "Toggle cursorline"
})
