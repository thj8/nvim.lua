return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
    vim.g.mkdp_auto_close = 0
    vim.keymap.set("n", "<leader>m", "<cmd>MarkdownPreview<CR>", { noremap = true, silent = true, desc = "Markdown 预览" })
  end,
  ft = { "markdown" },
}
