-- [[ Basic Keymaps ]]
-- Java Keymaps
vim.keymap.set("n", "<F3>", function()
  local var = vim.api.nvim_buf_get_name(0)
  local className = var:gsub("%.java", "")
  local result = className:match(".*/(.*)")
  -- print(var)
  vim.cmd(':! mvn compile exec:java -q -Dexec.mainClass="nl.cdaas.onboarder.service.' .. result .. '"')
end)

--Quick close file
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
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
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
--Git keybindings
keymap("n", "<leader>gg", ":Git<cr>", opts)
keymap("n", "<leader>pp", ":Git push<cr>", opts)
keymap("n", "<leader>gp", ":Git pull<cr>", opts)
--Nvimtree
keymap("n", "<leader>z", ":NvimTreeToggle<cr>", opts)
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
vim.keymap.set("n", "<leader>ff", ":Format<cr>")

vim.keymap.set("n", "<F6>", function()
  vim.cmd(":! mvn compile package -DskipTests && java -jar target/onboarder-0.0.1-SNAPSHOT.jar")
end, { silent = true })

-- Neorg keymaps
vim.keymap.set('n', '<leader>no', ":Neorg workspace notes<cr>", opts)
-- DAP keybinds
local dap = require('dap')
vim.keymap.set('n', '<leader>dt', dap.toggle_breakpoint, {})
vim.keymap.set('n', '<leader>dc', dap.continue, {})
-- Vim test
vim.keymap.set('n', '<leader>tn', ':TestNearest<CR>')
vim.keymap.set('n', '<leader>tf', ':TestFile<CR>')
vim.keymap.set('n', '<leader>ts', ':TestSuite<CR>')
vim.keymap.set('n', '<leader>tl', ':TestLast<CR>')
vim.keymap.set('n', '<leader>pm', ':! mvn org.pitest:pitest-maven:mutationCoverage<CR>')
vim.keymap.set('n', '<leader>ps', ':! serve /target/pit-reports/<CR>')
-- Harpoon
local harpoon = require('harpoon')
vim.keymap.set("n", "<leader>aa", function() harpoon:list():append() end)
vim.keymap.set("n", "<C-f>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-q>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-w>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-e>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-r>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
-- Go keymaps
vim.keymap.set("n", "<F4>", ':! go run . <CR>')



vim.keymap.set("n", "<F5>", ':RunMvn<CR>')
vim.cmd([[command! RunMvn lua RunMaven()]])
vim.cmd([[command! RunTest lua runMavenCommand]])


-- vim: ts=2 sts=2 sw=2 et
