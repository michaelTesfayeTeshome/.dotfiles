return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false,
	opts = {
		filters = {
			dotfiles = false,
		},
		git = {
			ignore = false,
		},
		renderer = {
			icons = {
				show = {
					folder_arrow = false,
				},
			},
			indent_markers = {
				enable = true,
			},
		},
	},
}
