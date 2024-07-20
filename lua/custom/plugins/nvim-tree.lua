return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- optional
  },
  config = function()
    require('nvim-tree').setup {
      hijack_netrw = false,

      hijack_directories = {
        enable = false,
        auto_open = false,
      },
    }
  end,
}
