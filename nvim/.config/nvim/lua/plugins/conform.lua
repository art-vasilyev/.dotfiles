return {
    "stevearc/conform.nvim",
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                lua = { "stylua" },
                python = { "isort", "black" },
            },
        })

        vim.keymap.set({ "n", "v" }, "<leader>cf", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 5000,
            })
        end)

        conform.formatters.black = {
            prepend_args = function(self, ctx)
                return { "--line-length", "79" }
            end,
        }

        conform.formatters.isort = {
            prepend_args = function(self, ctx)
                return { "--force-single-line-imports" }
            end,
        }
    end,
}
