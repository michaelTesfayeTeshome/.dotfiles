
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true})
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true})


-- Reselect visually selected after indentations
-- gv will reselect whatever was selected before, angle brackets are used for indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')


-- Maintain cursor position when yanking a visual selection
vim.keymap.set('v', 'y', 'myy`y')

vim.keymap.set('n', 'q:', ':q')
vim.keymap.set('c', 'W', 'w')

-- Insertion of ; or ,
vim.keymap.set('i', ';;', '<Esc>A;')
vim.keymap.set('i', ',,', '<Esc>A,')

-- clear search highliting
vim.keymap.set('n', ',<leader>', ':nohl<CR>')

-- open the current file in its default program (useful for opening html files and like that)
-- vim.keymap.set('n', '<leader>x', ':!xdg-open %<CR><CR>')


-- move the current line up or down
vim.keymap.set('i', '<A-k>', '<Esc>:move -2<CR>==gi')
vim.keymap.set('i', '<A-j>', '<Esc>:move +1<CR>==gi')
vim.keymap.set('n', '<A-k>', ':move -2<CR>==')
vim.keymap.set('n', '<A-j>', ':move +1<CR>==')
vim.keymap.set('v', '<A-k>', ":move -2<CR>gv=gv")
vim.keymap.set('v', '<A-j>', ":move '>+1<CR>gv=gv")


vim.keymap.set('n', '<leader><CR>', ':w<CR> :source ~/.config/nvim/init.lua<CR>')


vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true })

-- Nvim Tree
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<cr>', { noremap = true})

-- Open lazy
vim.keymap.set('n', '<leader>l', ':Lazy<cr>', { noremap = true})



vim.keymap.set('c', 'Q', 'q', {noremap = true})
