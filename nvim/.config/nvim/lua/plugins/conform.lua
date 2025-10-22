return {
    "stevearc/conform.nvim",
    config = function()
        local conform = require("conform")

        -- Constant path to the config file (relative to git root)
        local config_filename = ".conform.json"

        -- Default formatters if no config file present
        local defaults = {
            formatters = {
                lua = { "stylua" },
                python = { "isort", "black" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
            },
            args = {},
        }

        --- Load configuration from `.conform.json` in the git repository root
        --- Example `.conform.json`:
        -- {
        --   "formatters_by_ft": {
        --     "python": ["isort", "yapf"],
        --     "json": ["prettier"],
        --     "yaml": ["prettier"]
        --   },
        --   "args": {
        --     "yapf": ["--style", "{based_on_style: pep8, indent_width: 4}"],
        --     "isort": ["--profile", "open_stack", "--line-length", "79"]
        --   }
        -- }

        local load_config = function(bufnr)
            local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":h")
            local git_root = vim.fn.systemlist(
                "git -C " .. vim.fn.fnameescape(path) .. " rev-parse --show-toplevel"
            )[1]

            if vim.v.shell_error ~= 0 or not git_root then
                vim.notify("No git root found, using defaults", vim.log.levels.DEBUG)
                return nil
            end

            local cfg_path = git_root .. "/" .. config_filename
            if vim.fn.filereadable(cfg_path) == 0 then
                vim.notify("No " .. config_filename .. " found, using defaults", vim.log.levels.DEBUG)
                return nil
            end

            local ok_read, content = pcall(vim.fn.readfile, cfg_path)
            if not ok_read or not content then
                vim.notify("Failed to read " .. cfg_path, vim.log.levels.ERROR)
                return nil
            end

            local ok_parse, parsed = pcall(vim.fn.json_decode, table.concat(content, "\n"))
            if not ok_parse then
                vim.notify("Invalid JSON in " .. cfg_path, vim.log.levels.ERROR)
                return nil
            end

            return {
                formatters = parsed.formatters_by_ft or {},
                args = parsed.args or {},
            }
        end

        local orig_format = conform.format

        conform.format = function(opts)
            local bufnr = opts.buf or vim.api.nvim_get_current_buf()
            local cfg = load_config(bufnr) or defaults
            vim.notify("Using conform config: " .. vim.inspect(cfg), vim.log.levels.DEBUG)

            conform.formatters_by_ft = cfg.formatters

            for name, arg_list in pairs(cfg.args) do
                conform.formatters[name] = conform.formatters[name] or {}
                conform.formatters[name].prepend_args = function()
                    return arg_list
                end
            end

            orig_format(opts)
        end

        vim.keymap.set({ "n", "v" }, "<leader>cf", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 5000,
            })
        end, { desc = "Format current file with conform" })
    end,
}
