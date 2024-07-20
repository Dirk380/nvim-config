-- [[ Basic Keymaps ]]
vim.keymap.set('n', '<F12>', function()
  --Current buffer open en eerste lijn pakken + servicename
  local classPath = vim.api.nvim_buf_get_name(0)
  local parts = {}
  for part in classPath:gmatch '[^/]+' do
    table.insert(parts, part)
  end
  local class_with_java = parts[#parts]
  local className = class_with_java:gsub('%.java', '')
  local current_buffer = vim.fn.expand '%:p'
  local file = io.open(current_buffer, 'r')
  if file then
    local first_line = file:read '*line'
    local without_package = string.gsub(first_line, 'package', '')
    local without_colum = string.gsub(without_package, ';', '')
    local command_var = without_colum .. '.' .. className
    local trimmend_line = command_var:gsub('^%s*', '')
    vim.cmd(':! mvn compile exec:java -e -q -Dexec.mainClass="' .. trimmend_line .. '"')
    file:close()
  else
    print 'Error: Unable to open file'
  end
end)

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<F2>', function()
  vim.cmd('bot 10 new | term java ' .. vim.fn.expand '%')
end, { silent = true })

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
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)
--Git keybindings
keymap('n', '<leader>gg', ':Git<cr>', opts)
keymap('n', '<leader>pp', ':Git push<cr>', opts)
keymap('n', '<leader>gp', ':Git pull<cr>', opts)
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
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)

-- java keymap
vim.keymap.set('n', '<F5>', function()
  vim.cmd('bot 10 new | term java ' .. vim.fn.expand '%')
end, { silent = true })

vim.keymap.set('n', '<F6>', function()
  -- vim.cmd(":! mvn compile package -DskipTests=true && java -jar target/onboarder-0.0.1-SNAPSHOT.jar")
  vim.cmd ':! mvn clean install -Dfrontend.skip -DskipTests && java -jar target/*-SNAPSHOT.jar --spring.profiles.active=localhost '
end, { silent = true })

-- Pi-test keymap
vim.keymap.set('n', '<leader>pm', ':! mvn org.pitest:pitest-maven:mutationCoverage<CR>')
-- Vim test keymaps
vim.keymap.set('n', '<leader>tn', ':TestNearest<CR>')
vim.keymap.set('n', '<leader>tf', ':TestFile<CR>')
vim.keymap.set('n', '<leader>ts', ':TestSuite<CR>')
vim.keymap.set('n', '<leader>tl', ':TestLast<CR>')
-- Vim spellcheck
vim.keymap.set('n', '<leader>[[', 'z=')
vim.keymap.set('n', '<F3>', ':set invspell<CR>', { noremap = true, silent = true })

--Neogit
vim.keymap.set('n', '<leader>gg', ':Neogit<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>dv', ':DiffviewOpen<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>dc', ':DiffviewClose<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>ys', ':Telescope yaml_schema<CR>')
vim.keymap.set('n', '<leader>yc', ':lua print(vim.inspect(vim.lsp.get_active_clients()))<CR>')

-- Obsidian
vim.keymap.set('n', '<leader>nn', ':ObsidianNew<CR>')
vim.keymap.set('n', '<leader>ns', ':ObsidianSearch<CR>')
-- Nvim tree

vim.keymap.set('n', '<leader>to', ':NvimTreeOpen<CR>')
vim.keymap.set('n', '<leader>tc', ':NvimTreeClose<CR>')

-- vim: ts=2 sts=2 sw=2 et
--
