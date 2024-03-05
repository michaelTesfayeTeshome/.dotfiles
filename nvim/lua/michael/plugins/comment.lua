return {
        {
            'numToStr/Comment.nvim',
            lazy = false,
            config = function()
                require('Comment').setup({
                    -- has no support for jsx so use nvim-ts-context-commenstring for a commentstring suggestion
                    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
                })
            end,
        },
        {
            -- this plugin only changes the commentstring setting based on cursor location
            'JoosepAlviste/nvim-ts-context-commentstring',
            lazy = true,
            opts = {
                enable_autocmd = false
            },
        },
}
