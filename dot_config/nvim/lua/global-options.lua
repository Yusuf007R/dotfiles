local options = {
  expandtab = true,
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  swapfile = false,
  termguicolors = true,
  updatetime = 300,
  relativenumber = true,
}

local globals = {
  mapleader = " ",
  background = "dark",
  loaded_netrw = 1,
  loaded_netrwPlugin = 1,
}


local function loadTable(options, table)
  for k, v in pairs(options) do
    table[k] = v
  end
end

-- load options into vim.o
loadTable(options, vim.o)

-- load globals into vim.g
loadTable(globals, vim.g)

vim.wo.number = true
