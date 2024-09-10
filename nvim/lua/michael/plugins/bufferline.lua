return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	lazy = false,
	opts = {},
	keys = {
		{ "<leader>p", ":BufferLineCycleNext<cr>", desc = "Next Buffer" },
		{ "<leader>n", ":BufferLineCyclePrev<cr>", desc = "Previous Buffer" },
	},
}
