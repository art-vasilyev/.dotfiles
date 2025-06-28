return {
    {
        "tpope/vim-fugitive",
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
            vim.keymap.set('n', ']c', ':Gitsigns next_hunk<CR>', {})
            vim.keymap.set('n', '[c', ':Gitsigns prev_hunk<CR>', {})
            vim.keymap.set('n', '<leader>hr', ':Gitsigns reset_hunk<CR>', {})
            vim.keymap.set('n', '<leader>hp', ':Gitsigns preview_hunk<CR>', {})
            vim.keymap.set('n', '<leader>hs', ':Gitsigns stage_hunk<CR>', {})

            vim.keymap.set('v', '<leader>hs', function()
                require("gitsigns").stage_hunk(
                    { vim.fn.line('.'), vim.fn.line('v') })
            end)

            vim.keymap.set('v', '<leader>hr', function()
                require("gitsigns").reset_hunk(
                    { vim.fn.line('.'), vim.fn.line('v') })
            end)
        end
    }
}
