vim.cmd('noremap <C-b> :noh<cr>:call clearmatches()<cr>') -- clear matches Ctrl+b

function map(mode, shortcut, command)
    vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
    map('n', shortcut, command)
end

function imap(shortcut, command)
    map('i', shortcut, command)
end

function vmap(shortcut, command)
    map('v', shortcut, command)
end

function cmap(shortcut, command)
    map('c', shortcut, command)
end

function tmap(shortcut, command)
    map('t', shortcut, command)
end

-- Exit Insert Mode
imap('jk', '<esc>')

-- sane regexes
nmap('/', '/\\v')
vmap('/', '/\\v')

-- don't jump when using *
-- nmap('*', '*<c-o>')

-- keep search matches in the middle of the window
nmap('n', 'nzzzv')
nmap('N', 'Nzzzv')

-- Same when jumping around
nmap('g;', 'g;zz')
--nmap('g', 'g,zz') -- for some reason doesn't work well

-- Open a Quickfix window for the last search.
-- nmap("<leader>?", ":execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>")

-- Begining & End of line in Normal mode
-- nmap('H', '^')
-- nmap('L', 'g_')

-- more natural movement with wrap on
nmap('j', 'gj')
nmap('k', 'gk')
vmap('j', 'gj')
vmap('k', 'gk')

-- Easy buffer navigation
nmap('<C-h>', '<C-w>h')
nmap('<C-j>', '<C-w>j')
nmap('<C-k>', '<C-w>k')
nmap('<C-l>', '<C-w>l')

-- Reselect visual block after indent/outdent
vmap('<', '<gv')
vmap('>', '>gv')

-- home and end line in command mode
-- cmap('<C-a>', '<Home>')
-- cmap('<C-e>', '<End>')

-- Terminal
-- ESC to go to normal mode in terminal
tmap('<C-s>', '<C-\\><C-n>')
tmap('<Esc><Esc>', '<C-\\><C-n>')

-- Easy window split; C-w v -> vv, C-w - s -> ss
-- nmap('vv', '<C-w>v')
-- nmap('ss', '<C-w>s')
vim.o.splitbelow = true -- when splitting horizontally, move coursor to lower pane
vim.o.splitright = true -- when splitting vertically, mnove coursor to right pane

-- PLUGINS

-- Find files using Telescope command-line sugar.
-- nmap("<C-p>", "<cmd>Telescope find_files<cr>")
-- nmap("<leader>f", "<cmd>Telescope live_grep<cr>")
-- nmap("<leader>bb", "<cmd>Telescope buffers<cr>")
-- nmap("<leader>hh", "<cmd>Telescope help_tags<cr>")

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>f', builtin.live_grep, {})
vim.keymap.set('n', '<leader>bb', builtin.buffers, {})
vim.keymap.set('n', '<leader>hh', builtin.help_tags, {})

-- LSP
-- nmap('K', '<cmd>Lspsaga hover_doc<cr>')
-- imap('<C-k>', '<cmd>Lspsaga hover_doc<cr>')
-- nmap('gh', '<cmd>Lspsaga lsp_finder<cr>')
-- nmap('<C-e>', '<cmd>Lspsaga show_line_diagnostics<CR>')

-- git
-- nmap('<C-g>', '<cmd>GitMessenger<cr>')


-- II go to just before the first non-blank text of the line
-- AA go to the end of the line
-- OO start editing on a new line above the current line
imap('II', '<Esc>I')
imap('AA', '<Esc>A')
imap('OO', '<Esc>O')

-- CC change what is on the right of the cursor
--  SS change the whole line
--  DD delete the current line (end in normal mode)
--  UU undo
-- imap('CC', '<Esc>C')
-- imap('SS', '<Esc>S')
-- imap('DD', '<Esc>dd')
imap('UU', '<Esc>u')

-- use <c-e> and <c-y> to type below and above text
-- save file
imap('<leader>s', '<cmd>w<cr>')
nmap('<leader>s', ':w<cr><esc>')

-- Mappings to move lines"

nmap('<A-j>', '<cmd>m .+1<cr>==')
nmap('<A-k>', '<cmd>m .-2<cr>==')
imap('<A-j>', '<Esc><cmd>m .+1<cr>==gi')
imap('<A-k>', '<Esc><cmd>m .-2<cr>==gi')
vmap('<A-j>', "<cmd>m '>+1<cr>gv=gv")
vmap('<A-k>', "<cmd>m '<-2<cr>gv=gv")


-- make . to work with visually selected lines
vmap('.', '<cmd>normal.<cr>')

-- buffer navigation
nmap('<Tab>', '<cmd>bnext<cr>')
nmap('<S-Tab>', '<cmd>bprev<cr>')
-- nmap('gb', '<cmd>buffer #<cr>')
nmap('<leader>lf', "<cmd>lua vim.lsp.buf.format()<cr>")
-- nmap('<leader>n', "<cmd>Telescope file_browser<cr>")
nmap('<C-n>', "<cmd>NvimTreeToggle<cr>")


-- Open Vim file
nmap('<leader>ev', '<cmd>tabedit $MYVIMRC<cr>')
nmap('<leader><space>', '<cmd>nohl<cr>')


nmap('<right>', '<C-w>5>')
nmap('<left>', '<C-w>5<')
nmap('<up>', '<C-w>5+')
nmap('<down>', '<C-w>5-')

-- open preveios edited file
nmap('<C-6>', '<cmd>e#<cr>')

-- add space in normal mode
nmap('<space>', 'a<space><esc>')

-- add space in normal mode
nmap('<space>', 'a<space><esc>')
nmap('<S-space>', 'i<space><esc>')
