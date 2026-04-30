return {
    "stevearc/conform.nvim",

    opts = {
        formatters_by_ft = {
            json = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
            lua = { "stylua" },
            python = { "ruff_format", "isort" },
            sql = { "sql_formatter" },
        },
    },

    config = function(_, opts)
        local conform = require("conform")

        conform.setup(opts)

        vim.keymap.set({ "n", "v" }, "<leader>cf", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 5000,
            })
        end, { desc = "Format current file with conform" })
    end,
}
