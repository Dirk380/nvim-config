return {
  {
    'nvim-neorg/neorg',
    dependencies = { 'luarocks.nvim' },
    -- put any other flags you wanted to pass to lazy here!
    config = function()
      require('neorg').setup {

        load = {
          ['core.defaults'] = {},
          ['core.concealer'] = {},
          ['core.pivot'] = {},
          ['core.itero'] = {},
          ['core.dirman'] = {

            config = {
              workspaces = {
                notes = '~/notes',
                politie = '~/notes/politie-notes/',
                persoonlijk = '~/notes/persoonlijk-notes/',
                cyber = '~/notes/cyber-sec/',
              },
              default_workspace = 'notes',
            },
          },
        },
      }
    end,
  },
}
