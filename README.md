# Neovim Lua 配置

一个现代化的 Neovim 配置，使用 Lua 语言编写，提供了丰富的功能和良好的开发体验。

## 📋 功能特性

### 核心功能
- ✅ 使用 lazy.nvim 插件管理器
- ✅ 自定义键位映射
- ✅ 智能代码补全
- ✅ 多语言 LSP 支持
- ✅ 代码格式化
- ✅ Git 集成
- ✅ Markdown 预览
- ✅ 翻译功能
- ✅ 文件树导航

### 语言支持
- 🐹 Go (gopls)
- 🐍 Python (pylsp)
- 🔧 C/C++ (clangd)
- 📱 Lua (lua-language-server)

## 🚀 安装说明

### 1. 安装依赖

**Neovim 0.11+**（推荐最新版本）

**系统依赖**：
- Git
- Python 3 (用于 Python LSP)
- Node.js (可选，用于某些插件)
- Go (用于 Go LSP)
- Clang/LLVM (用于 C/C++ LSP)
- Lua 语言服务器 (用于 Lua LSP)
- lazygit (用于 Git 集成)
- black (用于 Python 格式化)
- gofumpt (用于 Go 格式化)

**macOS 安装命令**：
```bash
# 安装核心依赖
brew install neovim git python go llvm lua-language-server lazygit black

# 安装 Go 工具
go install golang.org/x/tools/cmd/gofmt@latest
go install golang.org/x/tools/gopls@latest
go install mvdan.cc/gofumpt@latest

# 安装 Python LSP
pip install python-lsp-server flake8 isort
```

### 2. 安装配置

```bash
# 备份现有配置（如果有）
mv ~/.config/nvim ~/.config/nvim.bak

# 克隆配置
mkdir -p ~/.config
cd ~/.config
git clone https://github.com/thj8/nvim.lua nvim

# 启动 Neovim
nvim
```

首次启动时，lazy.nvim 会自动安装所有插件。

## ⌨️ 键位映射

### 基本映射
| 按键 | 功能 | 模式 |
|------|------|------|
| `Q` | 退出当前缓冲区 | 普通 |
| `<C-q>` | 退出所有缓冲区 | 普通 |
| `<C-s>` | 保存文件 | 普通 |
| `<leader>w` | 保存文件 | 普通 |
| `<C-g>` | 打开 lazygit | 普通 |
| `<leader>s` | 重新加载配置文件 | 普通 |
| `<leader>ev` | 编辑配置文件 | 普通 |
| `<leader>l` | 编辑文件 | 普通 |
| `bl` | 列出所有缓冲区 | 普通 |
| `bu` | 新建缓冲区 | 普通 |
| `bn` | 下一个缓冲区 | 普通 |
| `bp` | 上一个缓冲区 | 普通 |
| `bd` | 删除当前缓冲区 | 普通 |
| `Y` (可视模式) | 复制到系统剪贴板 | 可视 |
| `{{` (插入模式) | 自动展开代码块 | 插入 |

### LSP 映射
| 按键 | 功能 | 模式 |
|------|------|------|
| `gd` | 跳转到定义 | 普通 |
| `gD` | 跳转到声明 | 普通 |
| `gi` | 跳转到实现 | 普通 |
| `gr` | 查看引用 | 普通 |
| `K` | 悬停提示 | 普通 |
| `<leader>ca` | 代码操作 | 普通 |
| `<leader>rn` | 重命名 | 普通 |
| `<leader>f` | 格式化代码 | 普通 |
| `<leader>e` | 显示诊断 | 普通 |
| `[d` | 上一个诊断 | 普通 |
| `]d` | 下一个诊断 | 普通 |

### 补全映射
| 按键 | 功能 | 模式 |
|------|------|------|
| `<Tab>` | 接受补全选项 | 插入 |
| `<Enter>` | 接受补全选项 | 插入 |
| `<C-space>` | 打开补全菜单 | 插入 |
| `<C-n>` | 下一个补全选项 | 插入 |
| `<C-p>` | 上一个补全选项 | 插入 |
| `<C-e>` | 隐藏补全菜单 | 插入 |

## 📁 配置文件结构

```
~/.config/nvim/
├── init.lua              # 主入口文件
├── lua/
│   ├── core/             # 核心配置
│   │   ├── keymaps.lua   # 键位映射
│   │   ├── lazy.lua      # 插件管理器配置
│   │   └── options.lua   # 基本选项
│   └── plugins/          # 插件配置
│       ├── blink.cmp.lua  # 补全插件
│       ├── init.lua      # 插件列表
│       ├── lazygit.lua   # Git 集成
│       ├── lsp.lua       # LSP 配置
│       ├── markdown.lua  # Markdown 预览
│       ├── neo-tree.lua  # 文件树
│       ├── treesitter.lua # 语法高亮
│       └── translate.lua # 翻译功能
└── README.md             # 本文档
```

## 🎨 外观配置

- **配色方案**：catppuccin (默认使用 latte 亮色系)
- **文件图标**：nvim-web-devicons
- **字体**：建议使用 Nerd Font 字体
- **语法高亮**：nvim-treesitter (支持 lua、go、python、c 语言)
- **自定义高亮**：Go 语言函数名设置为蓝色

## 🔧 插件说明

### 核心插件
- **lazy.nvim** - 现代插件管理器
- **blink.cmp** - 快速的代码补全插件
- **nvim-web-devicons** - 文件图标
- **catppuccin** - 配色方案 (默认使用 latte 亮色系)
- **nvim-treesitter** - 语法高亮 (支持 lua、go、python、c 语言)

### 语言工具
- **nvim-lspconfig** - LSP 配置
- **conform.nvim** - 代码格式化
- **gopls** - Go 语言服务器
- **pylsp** - Python 语言服务器
- **clangd** - C/C++ 语言服务器
- **lua-language-server** - Lua 语言服务器

### 工具插件
- **lazygit.nvim** - Git 集成
- **markdown-preview.nvim** - Markdown 预览
- **neo-tree.nvim** - 文件树导航

### 插件冲突处理
- **补全插件**：建议只启用一个补全插件（blink.cmp 或 nvim-cmp），两个插件同时启用可能会冲突
- **格式化插件**：conform.nvim 与 LSP 格式化功能可能冲突，建议只使用一种
- **paste 模式**：启用 paste 模式会禁用补全功能，建议在正常编辑时禁用，仅在粘贴代码时启用

## 📝 使用说明

### 启动 Neovim
```bash
nvim
```

### 安装新插件
编辑 `lua/plugins/init.lua` 文件，添加新插件配置，然后重启 Neovim。

### 更新插件
在 Neovim 中运行：
```vim
:Lazy update
```

### 查看插件状态
```vim
:Lazy
```

### 格式化代码
保存文件时会自动格式化，也可以使用 `<leader>f` 手动格式化。

### 预览 Markdown
在 Markdown 文件中按 `<leader>m` 打开预览。

### 使用 Git
按 `<C-g>` 打开 lazygit 界面。

## ⚙️ 自定义配置

### 添加新的键位映射
编辑 `lua/core/keymaps.lua` 文件，添加新的映射。

### 修改基本选项
编辑 `lua/core/options.lua` 文件，修改 Neovim 选项。

### 添加新的 LSP 服务器
编辑 `lua/plugins/lsp.lua` 文件，添加新的服务器配置。

## 🐛 故障排除

### 插件安装失败
- 检查网络连接
- 确保 Git 已正确安装
- 查看 Neovim 日志：`~/.local/state/nvim/log`

### LSP 服务器未启动
- 确保已安装相应的 LSP 服务器
- 检查服务器是否在 PATH 中
- 查看 LSP 日志：`:LspInfo`

### 格式化不生效
- 确保已安装相应的格式化工具
- 检查 LSP 服务器是否支持格式化
- 查看 `lua/plugins/lsp.lua` 中的格式化配置

### 补全功能不工作
- 检查是否同时启用了多个补全插件（如 blink.cmp 和 nvim-cmp）
- 检查 paste 模式是否已禁用（`:set nopaste`）
- 检查 LSP 服务器是否正常运行（`:LspInfo`）
- 尝试手动触发补全（`<C-space>`）

## 📄 许可证

MIT License

## 🤝 贡献

欢迎提交 Issue 和 Pull Request 来改进这个配置。

---

**享受你的 Neovim 之旅！** 🚀
