return {
    {
        "nvimtools/none-ls.nvim",

        dependencies = {
            "nvim-lua/plenary.nvim",
            "saghen/blink.cmp",
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
            local capabilities = require('blink.cmp').get_lsp_capabilities()

            -- brew install pyright
            require('lspconfig').pyright.setup({ capabilities = capabilities })

            -- brew install lua-language-server
            require('lspconfig').lua_ls.setup({ capabilities = capabilities })

            -- brew install gopls
            require('lspconfig').gopls.setup({ capabilities = capabilities })

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
