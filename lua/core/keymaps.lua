local map = vim.keymap.set

-- 领袖键
vim.g.mapleader = ","

-- 保存和退出
map("n", "Q", ":q<CR>", { desc = "退出当前缓冲区" })
map("n", "<C-q>", ":qa<CR>", { desc = "退出所有缓冲区" })
map("n", "<C-s>", ":w<CR>", { desc = "保存文件" })

-- 自动插入代码快
map("i", "{{", "{<CR>}<UP><ESC>o", { desc = "自动展开代码块" })

-- 缓冲区
map("n", "bl", ":ls<CR>", { silent = true, desc = "列出所有缓冲区" })
map("n", "bu", ":enew<CR>", { silent = true, desc = "新建缓冲区" })
map("n", "bn", ":bnext<CR>", { silent = true, desc = "下一个缓冲区" })
map("n", "bp", ":bprevious<CR>", { silent = true, desc = "上一个缓冲区" })
map("n", "bd", ":bdelete<CR>", { silent = true, desc = "删除当前缓冲区" })

-- 可视模式复制到系统剪贴板
map("v", "Y", '"+y')

-- 配置文件相关
map("n", "<leader>s", ":source $MYVIMRC<CR>", { desc = "重新加载配置文件" })
map("n", "<leader>ev", ":edit $MYVIMRC<CR>", { desc = "编辑配置文件" })
map("n", "<leader>l", ":edit<CR>", { desc = "编辑文件" })

