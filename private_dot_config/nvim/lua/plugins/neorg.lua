require('neorg').setup {
  -- Tell Neorg what modules to load
  load = {
    ['core.defaults'] = {},                                     -- Load all the default modules
    ['core.concealer'] = {},                                    -- Allows for use of icons
    ['core.summary'] = {},                                      -- Allows for links
    ['core.integrations.treesitter'] = {},                      -- Allows tree sitters
    ['core.completion'] = { config = { engine = 'nvim-cmp' } }, -- Allows completion
    ['core.dirman'] = {                                         -- Manage your directories with Neorg
      config = {
        workspaces = {
          home = '~/ToDoList/home/',
          werk = '~/ToDoList/werk',
        },
        autodetect = true,
        autochdir = true,
      },
    },
  },
}
