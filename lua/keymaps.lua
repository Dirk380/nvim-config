-- [[ Basic Keymaps ]]
--Quick close file
vim.keymap.set("n", "<leader>pv" , vim.cmd.Ex)
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
-- Window navigation
keymap("n" ,"<C-h>","<C-w>h", opts)
keymap("n" ,"<C-j>","<C-w>j", opts)
keymap("n" ,"<C-k>","<C-w>k", opts)
keymap("n" ,"<C-l>","<C-w>l", opts)
--Git keybindings
keymap("n","<leader>gg", ":Git<cr>", opts)
keymap("n","<leader>pp", ":Git push<cr>", opts)
keymap("n","<leader>gp", ":Git pull<cr>", opts)
--Nvimtree
keymap("n", "<leader>f" ,":NvimTreeToggle<cr>", opts)
-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
-- Harpoon keymap
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
-- LSP keymaps
vim.keymap.set("n", "K", vim.lsp.buf.hover,{})
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
-- vim: ts=2 sts=2 sw=2 et
