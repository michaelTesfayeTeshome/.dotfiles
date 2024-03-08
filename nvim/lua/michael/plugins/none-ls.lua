local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.diagnostics.eslint_d.with({
					condition = function(utils)
						return utils.root_has_file({ ".eslintrc.js" })
					end,
				}),
				-- null_ls.builtins.diagnostics.phpstan, -- TODO: Only if config file
				null_ls.builtins.diagnostics.trail_space.with({ disabled_filetypes = { "NvimTree" } }),
				null_ls.builtins.formatting.eslint_d.with({
					condition = function(utils)
						return utils.root_has_file({ ".eslintrc.js", ".eslintrc.json" })
					end,
				}),
				null_ls.builtins.formatting.pint.with({
					condition = function(utils)
						return utils.root_has_file({ "vendor/bin/pint" })
					end,
				}),
				null_ls.builtins.formatting.prettier.with({
					condition = function(utils)
						return utils.root_has_file({
							".prettierrc",
							".prettierrc.json",
							".prettierrc.yml",
							".prettierrc.js",
							"prettier.config.js",
						})
					end,
				}),
			},
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 5000 })
						end,
					})
				end
			end,
		})
	end,
}
