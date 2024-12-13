return {
	"akinsho/bufferline.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	version = "4.9.0",
	lazy = false,
	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				mode = "buffers", -- set to "tabs" to only show tabpages instead
			},
		})
	end,
	keys = {
		{ "<leader>n", ":BufferLineCycleNext<cr>", desc = "Next Buffer" },
		{ "<leader>p", ":BufferLineCyclePrev<cr>", desc = "Previous Buffer" },
	},
}
