# Neovim 插件与快捷键清单

Leader 键: `,`

---

## 插件列表

| 插件 | 说明 |
|------|------|
| folke/lazy.nvim | 插件管理器 |
| nvim-lua/plenary.nvim | Lua 工具库 (依赖) |
| nvim-tree/nvim-web-devicons | 文件图标 |
| catppuccin/nvim | 主题 (latte 亮色) |
| neovim/nvim-lspconfig | LSP 配置 (gopls/pylsp/clangd/lua_ls) |
| saghen/blink.cmp | 自动补全 |
| rafamadriz/friendly-snippets | 代码片段 |
| nvim-treesitter/nvim-treesitter | 语法高亮 (lua/go/python/c) |
| folke/snacks.nvim | 多功能工具集 (picker/dashboard/explorer/...) |
| MunifTanjim/nui.nvim | UI 组件库 (neo-tree 依赖) |
| nvim-neo-tree/neo-tree.nvim | 文件树 |
| kdheepak/lazygit.nvim | LazyGit 集成 |
| JuanZoran/Trans.nvim | 翻译 |
| kkharji/sqlite.lua | SQLite (翻译插件依赖) |
| iamcco/markdown-preview.nvim | Markdown 预览 |

---

## 快捷键

### 通用 (core/keymaps.lua)

| 模式 | 快捷键 | 功能 |
|------|--------|------|
| n | `Q` | 退出当前缓冲区 |
| n | `<C-q>` | 退出所有缓冲区 |
| n | `<C-s>` | 保存文件 |
| i | `{{` | 自动展开代码块 `{↵}` |
| n | `bl` | 列出所有缓冲区 |
| n | `bu` | 新建缓冲区 |
| n | `bn` | 下一个缓冲区 |
| n | `bp` | 上一个缓冲区 |
| n | `bd` | 删除当前缓冲区 |
| v | `Y` | 复制到系统剪贴板 |
| n | `,s` | 重新加载配置文件 |
| n | `,ev` | 编辑配置文件 |
| n | `,l` | 编辑文件 |

### LSP (plugins/lsp.lua)

| 模式 | 快捷键 | 功能 |
|------|--------|------|
| n | `gd` | 跳转到定义 (被 snacks 覆盖) |
| n | `gD` | 跳转到声明 (被 snacks 覆盖) |
| n | `gi` | 跳转到实现 |
| n | `gr` | 查看引用 (被 snacks 覆盖) |
| n | `K` | 悬停提示 |
| n | `,ca` | 代码操作,code action |
| n | `,rn` | 重命名 |
| n | `,f` | 格式化 |
| n | `,e` | 显示诊断浮动窗口 (被 snacks 覆盖) |
| n | `[d` | 上一个诊断 |
| n | `]d` | 下一个诊断 |

### blink.cmp 补全 (enter 模式)

| 模式 | 快捷键 | 功能 |
|------|--------|------|
| i | `<Enter>` | 确认补全 |
| i | `<C-Space>` | 打开补全菜单/文档 |
| i | `<C-n>` / `<C-p>` | 选择下/上一项 |
| i | `<C-e>` | 关闭菜单 |
| i | `<C-k>` | 切换签名帮助 |

### neo-tree 文件树

| 模式 | 快捷键 | 功能 |
|------|--------|------|
| n | `ee` | 打开/关闭文件树 |

### lazygit

| 模式 | 快捷键 | 功能 |
|------|--------|------|
| n | `<C-g>` | 打开 LazyGit |

### snacks.nvim

#### 顶级 Pickers & Explorer

| 模式 | 快捷键 | 功能 |
|------|--------|------|
| n | `,<Space>` | 智能查找文件 |
| n | `,b` | 缓冲区列表 |
| n | `,/` | Grep 搜索 |
| n | `,:` | 命令历史 |
| n | `,n` | 通知历史 |
| n | `,e` | 文件浏览器 |

#### 查找文件 (find)

| 模式 | 快捷键 | 功能 |
|------|--------|------|
| n | `,fb` | 缓冲区列表 |
| n | `,fc` | 查找 nvim 配置文件 |
| n | `,ff` | 查找文件 |
| n | `,fg` | 查找 Git 文件 |
| n | `,fp` | 项目列表 |
| n | `,fr` | 最近文件 |

#### Git

| 模式 | 快捷键 | 功能 |
|------|--------|------|
| n | `,gb` | Git 分支 |
| n | `,gl` | Git Log |
| n | `,gL` | Git Log (当前行) |
| n | `,gs` | Git Status |
| n | `,gS` | Git Stash |
| n | `,gd` | Git Diff |
| n | `,gf` | Git Log (当前文件) |
| n | `,gi` | GitHub Issues (open) |
| n | `,gI` | GitHub Issues (all) |
| n | `,gp` | GitHub PR (open) |
| n | `,gP` | GitHub PR (all) |
| n | `,gB` | Git Browse (浏览器打开) |
| n | `,gg` | Lazygit (snacks) |

#### 搜索 (search)

| 模式 | 快捷键 | 功能 |
|------|--------|------|
| n | `,sb` | 搜索缓冲区行 |
| n | `,sB` | Grep 打开的缓冲区 |
| n | `,sg` | Grep 搜索 |
| n/x | `,sw` | 搜索当前词/选区 |
| n | `,"` | 寄存器列表 |
| n | `,/` | 搜索历史 |
| n | `,sa` | Autocmd 列表 |
| n | `,sc` | 命令历史 |
| n | `,sC` | 命令列表 |
| n | `,sd` | 诊断列表 |
| n | `,sD` | 缓冲区诊断 |
| n | `,sh` | 帮助文档 |
| n | `,sH` | 高亮组 |
| n | `,si` | 图标搜索 |
| n | `,sj` | 跳转列表 |
| n | `,sk` | 快捷键列表 |
| n | `,sl` | Location List |
| n | `,sm` | Marks |
| n | `,sM` | Man Pages |
| n | `,sp` | 搜索插件 |
| n | `,sq` | Quickfix List |
| n | `,sR` | 恢复上次搜索 |
| n | `,su` | Undo 历史 |
| n | `,ss` | LSP Symbols |
| n | `,sS` | LSP Workspace Symbols |

#### LSP (snacks 覆盖)

| 模式 | 快捷键 | 功能 |
|------|--------|------|
| n | `gd` | 跳转到定义 (snacks picker) |
| n | `gD` | 跳转到声明 (snacks picker) |
| n | `gr` | 引用列表 (snacks picker) |
| n | `gI` | 跳转到实现 (snacks picker) |
| n | `gy` | 跳转到类型定义 |
| n | `gai` | 入调用链 |
| n | `gao` | 出调用链 |

#### Toggle 开关

| 模式 | 快捷键 | 功能 |
|------|--------|------|
| n | `,us` | 拼写检查 |
| n | `,uw` | 自动换行 |
| n | `,uL` | 相对行号 |
| n | `,ud` | 诊断开关 |
| n | `,ul` | 行号开关 |
| n | `,uc` | 折叠级别 |
| n | `,uT` | Treesitter 高亮 |
| n | `,ub` | 亮/暗背景 |
| n | `,uh` | Inlay Hints |
| n | `,ug` | 缩进线 |
| n | `,uD` | Dim 模式 |

#### 其他

| 模式 | 快捷键 | 功能 |
|------|--------|------|
| n | `,z` | Zen 模式 |
| n | `,Z` | Zoom 模式 |
| n | `,.` | Scratch 缓冲区 |
| n | `,S` | 选择 Scratch 缓冲区 |
| n | `,bd` | 删除缓冲区 (snacks) |
| n | `,cR` | 重命名文件 |
| n | `,un` | 关闭所有通知 |
| n | `,N` | Neovim 新闻 |
| n | `,uC` | 主题切换 |
| n/t | `]]` | 下一个引用 |
| n/t | `[[` | 上一个引用 |
| n/t | `<C-/>` | 终端 |

### 翻译 (Trans.nvim)

| 模式 | 快捷键 | 功能 |
|------|--------|------|
| n/x | `mm` | 翻译 |
| n/x | `mk` | 自动播放发音 |
| n | `mi` | 输入翻译 |

### Markdown 预览

| 模式 | 快捷键 | 功能 |
|------|--------|------|
| n | `,m` | Markdown 预览 |
