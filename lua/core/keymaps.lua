local map = vim.keymap.set

-- 领袖键
vim.g.mapleader = ","

-- 保存和退出
map("n", "Q", ":q<CR>")
map("n", "<C-q>", ":qa<CR>")
map("n", "<C-s>", ":w<CR>")

-- 自动插入代码快
map("i", "{{", "{<CR>}<UP><ESC>o")

-- 缓冲区
map("n", "bl", ":ls<CR>", { silent = true })
map("n", "bu", ":enew<CR>", { silent = true })
map("n", "bn", ":bnext<CR>", { silent = true })
map("n", "bp", ":bprevious<CR>", { silent = true })
map("n", "bd", ":bdelete<CR>", { silent = true })

-- 可视模式复制到系统剪贴板
map("v", "Y", '"+y')

