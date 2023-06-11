local api = vim.api
local cmd = vim.cmd
local opt = vim.opt

-- ENV variable
vim.env.VIRTUAL_ENV = 'venv'

opt.autoindent = true -- Autoindent when starting new line, or using o or O
opt.background = 'dark' -- When set to "dark" or "light", adjusts the default color groups for that background type.
opt.encoding = 'utf-8' -- Force utf-8 encoding
opt.hlsearch = true -- Enable search highlighting.
opt.ignorecase = true -- Ignore case when searching
opt.incsearch = true -- Enable highlighted case-insensitive incremential search.
opt.modeline = false -- Don't parse modelines (google vim modeline vulnerability).
opt.modifiable = true -- Make buffer modifiable
opt.showcmd = true -- Show the size of block one selected in visual mode
opt.showmatch = true -- The cursor will briefly jump to the matching brace when you insert one.
opt.splitright = true -- When on, splitting a window will put the new window right of the current one.
opt.ttimeoutlen = 50 -- Allow for mappings including Esc, while preserving zero timeout after pressing it manually
opt.updatetime = 100 -- Update time in ms
opt.wildoptions = 'pum' -- List of words that change how |cmdline-completion| is done.
opt.clipboard = 'unnamedplus' -- Register clipboard
opt.completeopt = 'menu,menuone,noselect' -- A comma separated list of options for Insert mode completion |ins-completion|
opt.wildmenu = true -- Autocomplete commands using nice menu in place of window status. Enable CTRL-N and CTRL-P to scroll through matches.
opt.wildmode = 'longest:full,full' -- For autocompletion, complete as much as you can.
opt.scrolloff = 10
opt.tabpagemax = 50

opt.shiftwidth = 4 -- When indenting with '>', use spaces width
opt.softtabstop = 4 -- Show existing tab with spaces width
opt.shiftwidth = 0 -- When indenting with '>', use spaces width
opt.tabstop = 2 -- Show existing tab with spaces width

opt.number = true -- Show line numbers on the sidebar
opt.relativenumber = true -- Show the line number relative to the line with the cursor in front of each line

cmd 'set expandtab'
cmd 'set hlsearch incsearch ignorecase smartcase'
cmd 'set timeoutlen=1000 ttimeoutlen=10'
cmd 'set noshowmode'
cmd 'set winaltkeys=no'
cmd 'set shortmess+=c'
cmd 'set noerrorbells'
cmd 'set termguicolors'
cmd 'set novisualbell'
cmd 'set vb t_vb='
cmd 'set nobackup nowritebackup noswapfile autoread'
cmd 'set ruler'
cmd 'syntax on'
cmd 'filetype plugin indent on'

api.nvim_command 'hi Comment     guibg=none guifg=#7CFC00'
api.nvim_command 'hi LineNr      guibg=none guifg=none'
api.nvim_command 'hi Normal      guibg=NONE'
api.nvim_command 'hi NormalFloat guibg=#2F4F4F'
api.nvim_command 'hi SignColumn  guibg=none'
api.nvim_command 'hi Visual      guibg=#00FA9A guifg=BLACK'
