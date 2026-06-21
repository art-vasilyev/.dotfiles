return {
  "art-vasilyev/gerrit-blame.nvim",
  config = function()
    require("gerrit-blame").setup()
    vim.keymap.set('n', '<leader>gR', require("gerrit-blame").open_gerrit)
  end,
}
