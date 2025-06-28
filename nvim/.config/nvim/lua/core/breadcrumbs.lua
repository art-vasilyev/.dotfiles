local M = {}
local ts_utils = require("nvim-treesitter.ts_utils")

local config = {
    type_patterns = { "function_definition", "class_definition" },
    separator = " › ",
    icons = {
        function_definition = "ƒ",
        class_definition = "{}",
    },
}

function M.setup(opts)
    config = vim.tbl_deep_extend("force", config, opts or {})
end

local function get_node_name(node)
    for i = 0, node:named_child_count() - 1 do
        local child = node:named_child(i)
        local type = child:type()
        if type == "identifier" or type:match("name") then
            return vim.treesitter.get_node_text(child, 0)
        end
    end
    return nil
end

local function format_node(node)
    local type = node:type()
    if not vim.tbl_contains(config.type_patterns, type) then
        return nil
    end
    local name = get_node_name(node)
    if not name then return nil end

    local icon = config.icons[type] or ""
    return icon .. " " .. name
end

local function get_breadcrumbs()
    local node = ts_utils.get_node_at_cursor()
    if not node then return "" end

    local parts = {}
    while node do
        local item = format_node(node)
        if item then
            table.insert(parts, 1, item)
        end
        node = node:parent()
    end

    return table.concat(parts, config.separator)
end

function M.breadcrumbs()
    local ok, result = pcall(get_breadcrumbs)
    return ok and result or ""
end

return M
