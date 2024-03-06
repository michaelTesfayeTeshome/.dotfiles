vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.keymappings")
require("config.misc")

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local opts = {
	defaults = {
		lazy = true,
	},
	performance = {
		cache = {
			enabled = true,
		},
		reset_packpath = true, -- reset the package path to improve startup time
		rtp = {
			reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
			paths = {}, -- add any custom paths here that you want to includes in the rtp
			disabled_plugins = {
				-- "gzip",
				-- "matchit",
				-- "matchparen",
				"netrw",
				"netrwPlugin",
				-- "tarPlugin",
				-- "tohtml",
				-- "tutor",
				-- "zipPlugin",
			},
		},
	},
}

require("lazy").setup("michael.plugins", opts)
