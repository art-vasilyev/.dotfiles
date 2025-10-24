return {
    {
        "nvimtools/none-ls.nvim",

        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                null_ls.builtins.diagnostics.yamllint,
                null_ls.builtins.diagnostics.terraform_validate,
            })
        end
    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            -- brew install pyright lua-language-server gopls
            vim.lsp.enable({'pyright', 'lua_ls', 'gopls'})

            vim.keymap.set("n", "gd", vim.lsp.buf.definition)

            vim.diagnostic.config({
                virtual_text = {
                    current_line = true,
                },
                signs = false,
                underline = true,
            })
        end
    }
}
