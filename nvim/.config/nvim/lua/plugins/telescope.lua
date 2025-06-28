return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            "nvim-telescope/telescope-live-grep-args.nvim",
            version = "^1.0.0",
        },
    },
    config = function()
        local telescope = require("telescope")
        local lga_actions = require("telescope-live-grep-args.actions")

        telescope.setup {
            defaults = {
                layout_strategy = 'horizontal',
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        width = { padding = 0 },
                        height = { padding = 0 },
                        preview_width = 0.5,
                    },
                },
                sorting_strategy = "ascending",
            },
            extensions = {
                live_grep_args = {
                    mappings = {
                        i = {
                            ["<C-k>"] = lga_actions.quote_prompt(),
                        }
                    }
                }
            }
        }
        telescope.load_extension("live_grep_args")
        local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
        vim.keymap.set('n', '<leader>fg', telescope.extensions.live_grep_args.live_grep_args)
        vim.keymap.set('v', '<leader>fg', live_grep_args_shortcuts.grep_visual_selection)

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files)
        vim.keymap.set('n', '<leader>fb', builtin.buffers)
        vim.keymap.set('n', '<leader>gs', builtin.git_status)
        vim.keymap.set('n', '<leader>fo', function()
            return builtin.lsp_document_symbols({
                symbols = { 'constant', 'function', 'class', 'method' } })
        end)
    end
}
