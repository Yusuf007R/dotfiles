local options = {
  number = true,
  relativenumber = true,
  expandtab = true,
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  swapfile = false,
  termguicolors = true,
  updatetime = 300,
}

local globals = {
  mapleader = " ",
  loaded_netrw = 1,
  loaded_netrwPlugin = 1,
}


local function loadTable(options, table)
  for k, v in pairs(options) do
    table[k] = v
  end
end

loadTable(options, vim.o)

loadTable(globals, vim.g)
