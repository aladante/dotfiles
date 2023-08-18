local cmd = vim.cmd
-- Default options:
require('kanagawa').setup {
  compile = false,  -- enable compiling the colorscheme
  undercurl = true, -- enable undercurls
  commentStyle = { italic = true },
  functionStyle = {},
  keywordStyle = { italic = true },
  statementStyle = { bold = true },
  typeStyle = {},
  transparent = false,   -- do not set background color
  dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
  terminalColors = true, -- define vim.g.terminal_color_{0,17}
  colors = {
    palette = {},
    theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
  },
  overrides = function(colors) -- add/modify highlights
    return {}
  end,
  theme = 'lotus', -- Load "wave" theme when 'background' option is not set
  background = {
    -- map the value of 'background' option to a theme
    light = 'lotus',
    dark = 'dragon', -- try "dragon" !
  },
}
cmd 'colorscheme kanagawa'
