return {
	"echasnovski/mini.nvim",
	version = false,
	lazy = false,
	config = function()
		local statusline = require("mini.statusline")
		statusline.setup({
			set_vim_settings = false,
		})
		-- Line:Column
		statusline.section_location = function()
			return "%2l:%-2v"
		end

		require("mini.pairs").setup()
		require("mini.surround").setup({
			mappings = {
				add = "<leader>sa", -- add surrounding
				delete = "<leader>sd", -- Delete surrounding
				find = "<leader>sf", -- Find surrounding (to the right)
				find_left = "<leader>sF", -- Find surrounding (to the left)
				highlight = "<leader>sh", -- Highlight surrounding
				replace = "<leader>sr", -- Replace surrounding
				update_n_lines = "<leader>sn", -- Update `n_lines`
			},
		})
	end,
}
