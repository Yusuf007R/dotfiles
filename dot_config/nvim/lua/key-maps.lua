local map = vim.keymap.set


map({ 'n', 'i', 'v' }, '<C-s>', '<cmd>:w<CR>')

map('n', '<leader>ln', function()
  vim.o.relativenumber = not vim.o.relativenumber
end, {
  desc = "Toggle relative line numbers"
})


map('n', '<leader>cl', function()
  vim.o.cursorline = not vim.o.cursorline
end, {
  desc = "Toggle cursorline"
})
