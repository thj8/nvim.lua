return {
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "latte", -- 默认使用亮色系
      })
      vim.cmd.colorscheme "catppuccin"
    end,
  },
}
