-- completion engine (handles the visualization of suggestions), nvim-cmp doesn't give completion suggestions by itself
-- it needs extra sources. It handles the UI for the completion menu.
return {
	"hrsh7th/nvim-cmp", -- Autocompletion plugin
	event = "InsertEnter",
	dependencies = {
		"neovim/nvim-lspconfig", -- Collection of configurations for built-in LSP client
		"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"hrsh7th/cmp-nvim-lsp", -- to get auto import on complete if the LSP supports it
		"hrsh7th/cmp-buffer", -- suggestions from the current buffer like commented
		"hrsh7th/cmp-path", -- completes file paths
		"hrsh7th/cmp-nvim-lua", -- completes for lua and neovim apis
		"saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
		{
			"L3MON4D3/LuaSnip", -- Snippets plugin, provides snippet sources so cmp can show completions

			build = (function()
				-- Build Step is needed for regex support in snippets
				-- This step is not supported in many windows environments
				-- Remove the below condition to re-enable on windows
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
		},
		"saadparwaiz1/cmp_luasnip",
		"onsails/lspkind-nvim",
	},
	config = function()
		-- Add additional capabilities supported by nvim-cmp
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local lspconfig = require("lspconfig")

		-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
		local servers = { "clangd", "rust_analyzer", "pyright", "tsserver" }
		for _, lsp in ipairs(servers) do
			lspconfig[lsp].setup({
				-- on_attach = my_custom_on_attach,
				capabilities = capabilities,
			})
		end

		-- luasnip setup
		local luasnip = require("luasnip")
		luasnip.config.setup({})

		-- nvim-cmp setup
		local cmp = require("cmp")
		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			completion = { completeopt = "menu,menuone,noinsert" },
			mapping = cmp.mapping.preset.insert({
				["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Up
				["<C-d>"] = cmp.mapping.scroll_docs(4), -- Down
				-- C-b (back) C-f (forward) for snippet placeholder navigation.
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
			},
		})
	end,
}
