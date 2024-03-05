vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4


vim.opt.smartindent = true
vim.opt.breakindent = true

vim.opt.wrap = true

vim.opt.number = true
vim.opt.relativenumber = true


vim.opt.wildmode = 'longest:full,full'

vim.opt.title = true
vim.opt.termguicolors = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

vim.opt.clipboard = 'unnamedplus'       -- use system clipboard

vim.opt.confirm = true

vim.opt.signcolumn = 'yes:1'

vim.opt.undofile = false
vim.opt.backup = true
vim.opt.backupdir:remove('.')
