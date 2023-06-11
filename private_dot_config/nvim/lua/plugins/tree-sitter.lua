-- TreeSitter highlight
require("nvim-treesitter.configs").setup({
  disable = function(lang, bufnr) -- Disable in large C++ buffers
    return vim.api.nvim_buf_line_count(bufnr) > 50000
  end,
  highlight = {
    enable = true,
    language_tree = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
  },
  indent = { enable = true },
  refactor = { highlight_definitions = { enable = true } },
  autotag = { enable = true },
  context_commentstring = { enable = true },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
})
