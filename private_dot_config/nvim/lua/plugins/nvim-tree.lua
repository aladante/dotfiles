local g = vim.g

g.nvim_tree_side = "left"
g.nvim_tree_width = 26
g.nvim_tree_allow_resize = 1

-- Mappings for nvimtree

vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

require("nvim-tree").setup({
	disable_netrw = true,
	hijack_netrw = true,
	open_on_tab = false,
	hijack_cursor = false,
	update_cwd = false,
	diagnostics = {
		enable = false,
		icons = { hint = "", info = "", warning = "", error = "" },
	},
	update_focused_file = { enable = true, update_cwd = true, ignore_list = {} },
	system_open = { cmd = nil, args = {} },
	filters = { dotfiles = false, custom = {} },
	git = { enable = true, ignore = true, timeout = 500 },
	view = {
		width = 30,
		side = "left",
		number = false,
		relativenumber = false,
		signcolumn = "yes",
	},
	trash = { cmd = "trash", require_confirm = true },
})
