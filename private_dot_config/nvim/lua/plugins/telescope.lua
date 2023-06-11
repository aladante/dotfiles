require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
    selection_strategy = 'reset',
    layout_strategy = 'vertical',
    layout_config = {
      horizontal = { mirror = false },
      vertical = { mirror = false },
    },
    path_display = { 'absolute', 'truncate' },
  },
}
