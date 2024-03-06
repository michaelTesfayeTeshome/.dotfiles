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
	end,
}
