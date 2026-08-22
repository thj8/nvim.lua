return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- 使用新的 vim.lsp.start API
      local function setup_lsp_server(server_name, config)
        vim.api.nvim_create_autocmd("FileType", {
          pattern = config.filetypes,
          callback = function()
            local client_id = vim.lsp.start {
              name = server_name,
              cmd = config.cmd,
              settings = config.settings,
              on_attach = config.on_attach,
              capabilities = config.capabilities,
              root_dir = config.root_dir,
            }
          end,
        })
      end

      -- 通用 on_attach 函数
      local function on_attach(client, bufnr)
        -- 已按需求移除保存时自动格式化；手动格式化用 <leader>f
      end

      -- 获取通用 capabilities（融合 blink.cmp 的能力，LSP 补全才生效）
      local capabilities = require('blink.cmp').get_lsp_capabilities(
        vim.lsp.protocol.make_client_capabilities()
      )

      -- 诊断配置
      vim.diagnostic.config({
        virtual_text = true,  -- 在行末显示错误信息
        signs = true,         -- 显示 E/W 标志
        underline = true,     -- 错误行下划线
        float = {
          border = "rounded", -- 浮动窗口样式
          source = "always",  -- 显示来源
        },
      })

      -- Go LSP 配置
      setup_lsp_server("gopls", {
        filetypes = { "go", "gomod", "gosum" },
        cmd = { "gopls" },
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = false,
              unusedwrite = false,
              modernize = false,
            },
            staticcheck = false,
            gofumpt = true, -- 启用 gofumpt 格式化
            codelenses = {
              generate = true,
              gc_details = true,
              test = true,
            },
          },
        },
      })

      -- Python LSP 配置（使用 pylsp）
      setup_lsp_server("pylsp", {
        filetypes = { "python" },
        cmd = { "pylsp" },
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          pylsp = {
            configurationSources = { "flake8" },
            plugins = {
              -- 启用格式化插件
              black = {
                enabled = true,
                line_length = 88
              },
              autopep8 = { enabled = false },
              yapf = { enabled = false },
              -- 启用 import 排序
              isort = {
                enabled = true,
                profile = "black"
              },
              -- 代码检查工具
              pylint = { enabled = true },
              pyflakes = { enabled = true },
              pycodestyle = {
                enabled = true,
                ignore = { "W391", "E501" },
                maxLineLength = 88
              },
              -- 其他功能
              jedi_completion = { enabled = true },
              jedi_hover = { enabled = true },
              jedi_references = { enabled = true },
              jedi_signature_help = { enabled = true },
              jedi_symbols = { enabled = true },
            }
          }
        }
      })

      -- C/C++ LSP 配置（使用 clangd）
      setup_lsp_server("clangd", {
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
        cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu", "--completion-style=detailed", "--function-arg-placeholders", "--fallback-style=llvm" },
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = function(fname)
          return vim.fs.find({ ".git", "compile_commands.json", "CMakeLists.txt" },
            { upward = true, path = vim.fs.dirname(fname) })[1]
        end
      })

      -- Lua LSP 配置（使用 lua-language-server）
      setup_lsp_server("lua_ls", {
        filetypes = { "lua" },
        cmd = { "lua-language-server" },
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
              path = vim.split(package.path, ";")
            },
            diagnostics = {
              enable = true,
              globals = { "vim", "hs" }
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
              },
              checkThirdParty = false
            },
            telemetry = {
              enable = false
            }
          }
        }
      })

      -- TypeScript / JavaScript LSP 配置
      setup_lsp_server("ts_ls", {
        filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
        cmd = { "typescript-language-server", "--stdio" },
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = function(fname)
          return vim.fs.find({ "tsconfig.json", "package.json", ".git" },
            { upward = true, path = vim.fs.dirname(fname) })[1]
        end,
        settings = {
          typescript = {
            suggest = { autoImports = true },
            preferences = { importModuleSpecifierPreference = "relative" },
          },
          javascript = {
            suggest = { autoImports = true },
            preferences = { importModuleSpecifierPreference = "relative" },
          },
        },
      })

      -- ESLint 保存时自动 --fix（curly + brace-style：补大括号、拆单行块）
      -- 手动触发：<leader>lf（只在项目有 eslint 配置或全局 fallback 可用时执行）
      -- （已按需求移除保存时自动 fix，改手动）
      local function eslint_fix()
        local fname = vim.api.nvim_buf_get_name(0)
        if fname == "" then return end
        local dir = vim.fs.dirname(fname)
        local config = vim.fs.find(
          { "eslint.config.js", "eslint.config.mjs", "eslint.config.ts" },
          { upward = true, path = dir }
        )[1]
        local cmd
        if config then
          local bin = vim.fs.dirname(config) .. "/node_modules/.bin/eslint"
          if vim.uv.fs_stat(bin) then
            cmd = { bin, "--fix", fname }
          end
        end
        if not cmd then
          local gbin = vim.fn.exepath("eslint")
          local gconf = vim.fn.expand("~/.config/eslint.config.mjs")
          if gbin ~= "" and vim.uv.fs_stat(gconf) then
            cmd = { gbin, "--config", gconf, "--fix", fname }
          end
        end
        if not cmd then
          vim.notify("eslint 不可用", vim.log.levels.WARN)
          return
        end
        -- eslint v10 会忽略 base path（cwd）之外的文件，cwd 必须切到文件目录
        local pos = vim.api.nvim_win_get_cursor(0)
        local r = vim.system(cmd, { cwd = dir, text = true }):wait()
        if r.code == 0 then
          vim.cmd("silent! edit!")
          pcall(vim.api.nvim_win_set_cursor, 0, pos)
        else
          vim.notify("eslint --fix 失败: " .. (r.stderr or ""), vim.log.levels.ERROR)
        end
      end
      vim.keymap.set("n", "<leader>lf", eslint_fix, { silent = true, desc = "eslint --fix" })

      -- 全局 LSP 键位映射
      local map = vim.keymap.set
      map("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true, desc = "跳转到定义" })
      map("n", "gD", vim.lsp.buf.declaration, { noremap = true, silent = true, desc = "跳转到声明" })
      map("n", "gi", vim.lsp.buf.implementation, { noremap = true, silent = true, desc = "跳转到实现" })
      map("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true, desc = "悬停提示" })
      map("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "代码操作" })
      map("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true, silent = true, desc = "重命名" })
      map("n", "<leader>f", function() vim.lsp.buf.format { async = true } end,
        { noremap = true, silent = true, desc = "格式化" })
      map("n", "<leader>e", vim.diagnostic.open_float, { noremap = true, silent = true, desc = "显示诊断" })
      map("n", "[d", vim.diagnostic.goto_prev, { noremap = true, silent = true, desc = "上一个诊断" })
      map("n", "]d", vim.diagnostic.goto_next, { noremap = true, silent = true, desc = "下一个诊断" })
      map("n", "<leader>q", ":cclose<CR>", { silent = true, desc = "关闭 quickfix" })
    end,
  },
}
