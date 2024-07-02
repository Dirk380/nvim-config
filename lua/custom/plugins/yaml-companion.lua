return {
  'agorgl/yaml-companion.nvim',
  brach = 'patch-1',
  -- 'someone-stole-my-name/yaml-companion.nvim',
  requires = {
    { 'neovim/nvim-lspconfig' },
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope.nvim' },
  },
  config = function()
    local cfg = require('yaml-companion').setup {
      -- detect k8s schemas based on file content
      builtin_matchers = {
        kubernetes = { enabled = true },
      },

      -- schemas available in Telescope picker
      schemas = {
        -- not loaded automatically, manually select with
        -- :Telescope yaml_schema
        {
          name = 'Kubernetes 1.27.10',
          uri = 'https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.27.10/all.json',
        },
        {
          name = 'Argo CD Application',
          uri = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json',
        },
        {
          name = 'Argo Workflows',
          uri = 'https://raw.githubusercontent.com/argoproj/argo-workflows/main/api/jsonschema/schema.json',
        },
        {
          name = 'Gitlab',
          uri = 'https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json',
        },
      },

      lspconfig = {
        settings = {
          yaml = {
            validate = true,
            -- format = { enable = true },
            -- hover = true,
            -- diagnostics = {
            --   enable = true,
            -- },
            schemaStore = {
              enable = false,
              url = '',
            },
            single_file_support = true,
            schemas = {
              -- ['https://raw.githubusercontent.com/argoproj/argo-workflows/main/api/jsonschema/schema.json'] = '*.yaml',
              ['https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.27.10/all.json'] = '*.yaml',
            },
            -- schemas = require('schemastore').yaml.schemas {
            --   select = {
            --     'kustomization.yaml',
            --     'GitHub Workflow',
            --   },
            -- },
          },
        },
      },
    }

    require('lspconfig')['yamlls'].setup(cfg)

    require('telescope').load_extension 'yaml_schema'

    -- get schema for current buffer
    local function get_schema()
      local schema = require('yaml-companion').get_buf_schema(0)
      if schema.result[1].name == 'none' then
        return ''
      end
      return schema.result[1].name
    end

    require('lualine').setup {
      sections = {
        lualine_x = { 'fileformat', 'filetype', get_schema },
      },
    }

    vim.keymap.set('n', '<leader>ys', ':Telescope yaml_schema<CR>')
    vim.keymap.set('n', '<leader>yc', ':lua print(vim.inspect(vim.lsp.get_active_clients()))<CR>')
  end,
}
