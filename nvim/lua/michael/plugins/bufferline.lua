return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	lazy = false,
	opts = {},
	keys = {
		{ "<leader>n", ":BufferLineCycleNext<cr>", desc = "Next Buffer" },
		{ "<leader>p", ":BufferLineCyclePrev<cr>", desc = "Previous Buffer" },
	},
}
