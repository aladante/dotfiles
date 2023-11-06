-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local remap = require("me.util").remap
local bufopts = { silent = true, noremap = true }

local M = {}

-- SWITCH THEME <ALT-T>
remap("n", "<M-t>", ':exec &bg=="light"? "set bg=dark" : "set bg=light"<CR>', bufopts, "Switch theme")

-- KEY BINDINGS
remap("n", "J", "5j", bufopts, "move 5 j")
remap("n", "K", "5k", bufopts, "move 5 k")
remap("v", "J", "5j", bufopts, "move 5 j")
remap("v", "K", "5k", bufopts, "move 5 k")

-- terminal remappings
remap("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", bufopts, "tmux nax")
remap("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", bufopts, "tmux nax")
remap("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", bufopts, "tmux nax")
remap("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", bufopts, "tmux nax")

remap("i", "<C-j>", "<cmd>TmuxNavigateDown<cr>", bufopts, "tmux nax")
remap("i", "<C-k>", "<cmd>TmuxNavigateUp<cr>", bufopts, "tmux nax")
remap("i", "<C-l>", "<cmd>TmuxNavigateRight<cr>", bufopts, "tmux nax")
remap("i", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", bufopts, "tmux nax")

remap("t", "<C-j>", "<c-\\><c-n>:TmuxNavigateDown<cr>", bufopts, "tmux nax")
remap("t", "<C-k>", "<c-\\><c-n>:TmuxNavigateUp<cr>", bufopts, "tmux nax")
remap("t", "<C-l>", "<c-\\><c-n>:TmuxNavigateRight<cr>", bufopts, "tmux nax")
remap("t", "<C-h>", "<c-\\><c-n>:TmuxNavigateLeft<CR>", bufopts, "tmux nax")

-- Navigation bufferline
remap("n", "<Leader>bd", "<cmd>bd<cr>", bufopts, "Close buffer")
remap("n", "<Leader>,", "<cmd>bprevious<cr>", bufopts, "+1 buffer")
remap("n", "<Leader>.", "<cmd>bnext<cr>", bufopts, "-1 buffer")

for i = 1, 9 do
	remap(
		"n",
		"<leader>" .. i,
		':lua require"bufferline".go_to_buffer(' .. i .. ")<CR>",
		bufopts,
		"Go to buffer number"
	)
	remap(
		"t",
		"<leader>" .. i,
		'<C-\\><C-n>:lua require"bufferline".go_to_buffer(' .. i .. ")<CR>",
		bufopts,
		"Go to buffer number"
	)
end

-- Package manager
remap("n", "<Leader>u", "<cmd>Lazy<cr>", bufopts, "update packeges")

-- disable search highlighting by pressing enter
remap("n", "<cr>", "<cmd>:nohlsearch<cr><cr>")

-- nvim-tree
remap("n", "<leader>nn", "<cmd>NvimTreeToggle<cr>", bufopts, "Open file browser")
remap("n", "<leader>nf", "<cmd>NvimTreeFindFileToggle<cr>", bufopts, "Find file in browser")

-- telescope
remap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", bufopts, "Find file")
remap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", bufopts, "Grep")
remap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", bufopts, "Find buffer")
remap("n", "<leader>fm", "<cmd>Telescope marks<cr>", bufopts, "Find mark")
remap("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", bufopts, "Find references (LSP)")
remap("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", bufopts, "Find symbols (LSP)")
remap("n", "<leader>fc", "<cmd>Telescope lsp_incoming_calls<cr>", bufopts, "Find incoming calls (LSP)")
remap("n", "<leader>fo", "<cmd>Telescope lsp_outgoing_calls<cr>", bufopts, "Find outgoing calls (LSP)")
remap("n", "<leader>fi", "<cmd>Telescope lsp_implementations<cr>", bufopts, "Find implementations (LSP)")
remap("n", "<leader>fx", "<cmd>Telescope diagnostics bufnr=0<cr>", bufopts, "Find errors (LSP)")
require("which-key").register({
	f = {
		name = "find",
	},
}, { prefix = "<leader>" })

-- trouble
remap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", bufopts, "Display errors")
remap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", bufopts, "Display workspace errors")
remap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", bufopts, "Display document errors")
require("which-key").register({
	x = {
		name = "errors",
	},
}, { prefix = "<leader>" })

-- nvim-dap
remap("n", "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", bufopts, "Set breakpoint")
remap(
	"n",
	"<leader>bc",
	"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
	bufopts,
	"Set conditional breakpoint"
)
remap(
	"n",
	"<leader>bl",
	"<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
	bufopts,
	"Set log point"
)
remap("n", "<leader>br", "<cmd>lua require'dap'.clear_breakpoints()<cr>", bufopts, "Clear breakpoints")
remap("n", "<leader>ba", "<cmd>Telescope dap list_breakpoints<cr>", bufopts, "List breakpoints")
require("which-key").register({
	b = {
		name = "breakpoints",
	},
}, { prefix = "<leader>" })

-- DEBUG
remap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", bufopts, "Continue")
remap("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>", bufopts, "Step over")
remap("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>", bufopts, "Step into")
remap("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>", bufopts, "Step out")

remap("n", "<F5>", ':lua require"dap".continue()<CR>', bufopts, "Debug Continue debug")
remap("n", "<F8>", ':lua require"dap".step_over()<CR>', bufopts, "Debug Step over ")
remap("n", "<F7>", ':lua require"dap".step_into()<CR>', bufopts, "Debug step into")
remap("n", "<S-F8>", ':lua require"dap".step_out()<CR>', bufopts, "Debug step out")

remap("n", "<leader>da", ":lua Attach_to_debug()<CR>", bufopts, "connect debugger")
remap("n", "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>", bufopts, "Disconnect")
remap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", bufopts, "Terminate")
remap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", bufopts, "Open REPL")
remap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", bufopts, "Run last")
remap("n", "<leader>di", function()
	require("dap.ui.widgets").hover()
end, bufopts, "Variables")
remap("n", "<leader>d?", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end, bufopts, "Scopes")
remap("n", "<leader>df", "<cmd>Telescope dap frames<cr>", bufopts, "List frames")
remap("n", "<leader>dh", "<cmd>Telescope dap commands<cr>", bufopts, "List commands")
require("which-key").register({
	d = {
		name = "debug",
	},
}, { prefix = "<leader>" })

remap("n", "<space>ff", function()
	vim.lsp.buf.format({ async = true })
end, bufopts, "Format file")
remap("v", "<space>fs", function()
	vim.lsp.buf.format({
		async = true,
		range = {
			["start"] = vim.api.nvim_buf_get_mark(0, "<"),
			["end"] = vim.api.nvim_buf_get_mark(0, ">"),
		},
	})
end, bufopts, "Format selection")
require("which-key").register({
	d = {
		name = "format",
	},
}, { prefix = "<space>" })

-- GIT
remap("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", bufopts, "Toggle git blame")
require("which-key").register({
	g = {
		name = "git",
	},
}, { prefix = "<leader>" })

return M
