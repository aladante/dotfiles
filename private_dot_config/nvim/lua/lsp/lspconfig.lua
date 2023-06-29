local lspconfig = require("lspconfig")
local lsp_status = require("lsp-status")

local on_attach = require("lsp.defaults").on_attach

local servers = {
	bashls = {},
	cssls = {
		filetypes = { "css", "scss", "less", "sass" },
		root_dir = lspconfig.util.root_pattern("package.json", ".git"),
	},
	graphql = {},
	html = {},
	jsonls = {},
	dockerls = {},
	yamlls = {},
	terraformls = {},
	pyright = {},
	marksman = {},
	lua_ls = {
		cmd = { "lua-language-server" },
		settings = {
			Lua = {
				diagnostics = { globals = { "vim" } },
				runtime = {
					version = "LuaJIT",
					path = vim.split(package.path, ";"),
				},
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					},
				},
			},
		},
	},
	eslint = {},
	gradle_ls = {},
	tsserver = {},
	ansiblels = {},
	docker_compose_language_service = {},
	jsonnet_ls = {},
}

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	float = { border = "single" },
})

vim.lsp.protocol.CompletionItemKind = {
	" [text]",
	" [method]",
	"ƒ [function]",
	" [constructor]",
	" [field]",
	" [variable]",
	" [class]",
	" [interface]",
	" [module]",
	" [property]",
	" [unit]",
	" [value]",
	" [enum]",
	" [keyword]",
	"﬌ [snippet]",
	" [color]",
	" [file]",
	" [reference]",
	" [dir]",
	" [enummember]",
	" [constant]",
	" [struct]",
	"  [event]",
	" [operator]",
	" [type]",
}

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

for server, config in pairs(servers) do
	if type(config) == "function" then
		config = config()
	end
	config.on_attach = on_attach
	config.capabilities = vim.tbl_deep_extend("keep", config.capabilities or {}, lsp_status.capabilities)
	lspconfig[server].setup(config)
end

-- F
