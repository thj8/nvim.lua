vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autochdir = true
vim.opt.cursorline = true
vim.opt.linespace = 0
vim.opt.showmatch = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.autoindent = true
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.cindent = true
vim.opt.smartindent = true

-- 折叠：基于 Treesitter（函数 / if / for 的 {} 块自动可折叠）
-- 依赖对应语言的 parser 已安装（见 treesitter.lua 的 ensure_installed）
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99          -- 打开文件时默认全部展开
vim.opt.foldlevelstart = 99
vim.opt.foldcolumn = "1"        -- 左侧显示折叠标记列（可选，不要可设为 "0"）
vim.opt.fillchars:append({ fold = " " })

-- 状态栏：用 %F 显示绝对全路径（默认 %f 受 autochdir 影响会退化成文件名）
vim.opt.statusline = "%F %m%r%h%w%= %-14.(%l,%c%V%) %P"

