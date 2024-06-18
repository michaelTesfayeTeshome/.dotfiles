return {
	"stevearc/conform.nvim",
	lazy = true,
	event = "BufWritePre",
	opts = {
		notify_on_error = false,
		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 1500,
			lsp_fallback = true,
		},
		formatters_by_ft = {
			lua = { "stylua" },
			-- Conform will run multiple formatters sequentially
			-- python = { "isort", "black" },
			-- Use a sub-list to run only the first available formatter
			javascript = { { "prettierd", "prettier" } },
			javascriptreact = { { "prettierd", "prettier" } },
			typescript = { { "prettierd", "prettier" } },
			typescriptreact = { { "prettierd", "prettier" } },
			vue = { "prettier" },
			css = { "prettier" },
			scss = { "prettier" },
			less = { "prettier" },
			html = { "prettier" },
			json = { "prettier" },
			jsonc = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
			php = { { "pint" } },
		},
	},
}
