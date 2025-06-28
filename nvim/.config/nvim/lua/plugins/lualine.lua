return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require("core.breadcrumbs").setup({
            separator = "  ",
        })
        require('lualine').setup({
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = {
                    'filename',
                    require("core.breadcrumbs").breadcrumbs,
                },
                lualine_x = {},
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
        })
    end
}
