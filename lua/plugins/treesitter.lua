-- 现代版 nvim-treesitter 配置
-- 注意：新版已移除 :TSInstall 命令 和 opts.ensure_installed / highlight / indent 模块
-- parser 需要 tree-sitter CLI 才能编译：brew install tree-sitter
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",

  config = function()
    -- ① 启动时确保这些语言已安装（等价于旧版 ensure_installed）
    --    幂等：已装的会自动跳过，不会重复编译
    local wanted = { "typescript", "tsx", "lua", "go", "python", "c" }
    require("nvim-treesitter").install(wanted)

    -- ② 打开文件时：有 parser 就启动高亮 + 折叠；没有就异步安装（重开即生效）
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
        if not lang then
          return
        end
        local ok = pcall(vim.treesitter.start, args.buf, lang)
        if not ok then
          -- parser 缺失 → 自动安装
          require("nvim-treesitter").install({ lang })
        end
      end,
    })
  end,
}
