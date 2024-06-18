return {
	"neovim/nvim-lspconfig",
	event = "VeryLazy",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		-- Useful status updates for LSP.
		{ "j-hui/fidget.nvim", opts = {} },
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				-- create a function that lets us more easily define mappings specific
				-- for LSP related items. It sets the mode, buffer and description for us each time.
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end
				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
				map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
				map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
				map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
				map("K", vim.lsp.buf.hover, "Hover Documentation")
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.server_capabilities.documentHighlightProvider then
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.clear_references,
					})
				end
			end,
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
		local servers = {
			gopls = {
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
						gofumpt = true,
					},
				},
			},
			clangd = {},
			tailwindcss = {},
			tsserver = {},
			intelephense = {
				commands = {
					IntelephenseIndex = {
						function()
							vim.lsp.buf.execute_command({ command = "intelephense.index.workspace" })
						end,
					},
				},
				on_attach = function(client, bufnr)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
					-- if client.server_capabilities.inlayHintProvider then
					--   vim.lsp.buf.inlay_hint(bufnr, true)
					-- end
				end,
			},
			phpactor = {
				on_attach = function(client, bufnr)
					client.server_capabilities.completionProvider = false
					client.server_capabilities.hoverProvider = false
					client.server_capabilities.implementationProvider = false
					client.server_capabilities.referencesProvider = false
					client.server_capabilities.renameProvider = false
					client.server_capabilities.selectionRangeProvider = false
					client.server_capabilities.signatureHelpProvider = false
					client.server_capabilities.typeDefinitionProvider = false
					client.server_capabilities.workspaceSymbolProvider = false
					client.server_capabilities.definitionProvider = false
					client.server_capabilities.documentHighlightProvider = false
					client.server_capabilities.documentSymbolProvider = false
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end,
				init_options = {
					["language_server_phpstan.enabled"] = false,
					["language_server_psalm.enabled"] = false,
				},
				handlers = {
					["textDocument/publishDiagnostics"] = function() end,
				},
			},
			--[[ volar = {
				on_attach = function(client, bufnr)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end,
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			}, ]]
			lua_ls = {
				-- cmd = {...},
				-- filetypes { ...},
				-- capabilities = {},
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						workspace = {
							checkThirdParty = false,
							-- Tells lua_ls where to find all the Lua files that you have loaded
							-- for your neovim configuration.
							library = {
								"${3rd}/luv/library",
								unpack(vim.api.nvim_get_runtime_file("", true)),
							},
							-- If lua_ls is really slow on your computer, you can try this instead:
							-- library = { vim.env.VIMRUNTIME },
						},
						completion = {
							callSnippet = "Replace",
						},
						-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
						-- diagnostics = { disable = { 'missing-fields' } },
					},
				},
			},
		}

		-- Mason is a package manager for managing LSP servers, linters and formatters
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua", -- Used to format lua code
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
