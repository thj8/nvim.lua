return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",

  opts = {
    ensure_installed = {
      "lua",
      "go",
      "python",
      "c",
    },

    sync_install = false,

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },

    indent = {
      enable = true,
    },
  },

  -- ⚠️ 注意：这里不再 require configs
  config = function(_, opts)
    -- Lazy.nvim 会自动把 opts 喂给 treesitter
    -- 我们这里只做“补丁行为”

    -- ✅ Neovim 0.11：显式启动 Treesitter highlighter
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local ft = vim.bo[args.buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)
        if lang then
          pcall(vim.treesitter.start, args.buf, lang)
        end
      end,
    })

    -- ✅ Go：关掉内置 syntax，避免抢高亮
    -- vim.api.nvim_create_autocmd("FileType", {
    --   pattern = "go",
    --   callback = function()
    --     vim.cmd("syntax off")
    --   end,
    -- })
  end,
}
