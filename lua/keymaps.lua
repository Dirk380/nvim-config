-- [[ Basic Keymaps ]]

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<F2>", function()
  vim.cmd("bot 10 new | term java " .. vim.fn.expand "%")
end, { silent = true })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', '<leader>ff', ':Format<CR>')

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
-- Window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
--Git keybindings
keymap("n", "<leader>gg", ":Git<cr>", opts)
keymap("n", "<leader>pp", ":Git push<cr>", opts)
keymap("n", "<leader>gp", ":Git pull<cr>", opts)
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
-- LSP keymaps
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)

-- java keymap
vim.keymap.set("n", "<F5>", function()
  vim.cmd("bot 10 new | term java " .. vim.fn.expand "%")
end, { silent = true })

vim.keymap.set("n", "<F6>", function()
  -- vim.cmd(":! mvn compile package -DskipTests=true && java -jar target/onboarder-0.0.1-SNAPSHOT.jar")
  vim.cmd(":! gradle bootRun -x test")
end, { silent = true })

-- Neorg keymaps
vim.keymap.set('n', '<leader>no', ":Neorg workspace notes<cr>", opts)
-- DAP keybinds
local dap = require('dap')
vim.keymap.set('n', '<leader>dt', dap.toggle_breakpoint, {})
vim.keymap.set('n', '<leader>dc', dap.continue, {})
-- Pi-test keymap
vim.keymap.set('n', '<leader>pm', ':! mvn org.pitest:pitest-maven:mutationCoverage<CR>')
-- Vim test keymaps
vim.keymap.set('n', '<leader>tn', ':TestNearest<CR>')
vim.keymap.set('n', '<leader>tf', ':TestFile<CR>')
vim.keymap.set('n', '<leader>ts', ':TestSuite<CR>')
vim.keymap.set('n', '<leader>tl', ':TestLast<CR>')
-- Spectre keymaps
vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
  desc = "Toggle Spectre"
})
vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
  desc = "Search current word"
})
vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
  desc = "Search current word"
})
vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = "Search on current file"
})
-- vim: ts=2 sts=2 sw=2 et
