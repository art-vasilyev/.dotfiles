return {
    "art-vasilyev/yapath.nvim",
    config = function()
        require("yapath").setup()
        vim.keymap.set("n", "gG", require("yapath").open_git_url)
    end,
}
