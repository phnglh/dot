return {
  "folke/snacks.nvim",
  opts = {
    explorer = {
      enabled = false,
    },
    terminal = {
      win = {
        border = "rounded",
        position = "float",
      },
    },
  },
  keys = {
    {
      "<leader>t",
      function()
        Snacks.terminal.toggle()
      end,
      desc = "Toggle Terminal",
    },
  },
}
