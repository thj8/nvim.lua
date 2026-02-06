-- ~/.config/nvim/lua/plugins/lsp.lua
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
        -- 启用 LSP 提供的格式化能力
        if client.server_capabilities.documentFormattingProvider then
          -- 仅在支持格式化的 LSP 上启用自动格式化
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({
                async = false,
                filter = function(cli)
                  -- 只使用当前客户端的格式化功能
                  return cli.name == client.name
                end
              })
            end
          })
        end
      end
      
      -- 获取通用 capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      
      -- Go LSP 配置
      setup_lsp_server("gopls", {
        filetypes = { "go", "gomod", "gosum" },
        cmd = { "gopls" },
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              unusedwrite = true,
            },
            staticcheck = true,
            gofumpt = true,  -- 启用 gofumpt 格式化
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
          return vim.fs.find({ ".git", "compile_commands.json", "CMakeLists.txt" }, { upward = true, path = vim.fs.dirname(fname) })[1]
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
      
      -- 全局 LSP 键位映射
      local map = vim.keymap.set
      map("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true, desc = "跳转到定义" })
      map("n", "gD", vim.lsp.buf.declaration, { noremap = true, silent = true, desc = "跳转到声明" })
      map("n", "gi", vim.lsp.buf.implementation, { noremap = true, silent = true, desc = "跳转到实现" })
      map("n", "gr", vim.lsp.buf.references, { noremap = true, silent = true, desc = "查看引用" })
      map("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true, desc = "悬停提示" })
      map("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "代码操作" })
      map("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true, silent = true, desc = "重命名" })
      map("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, { noremap = true, silent = true, desc = "格式化" })
      map("n", "<leader>e", vim.diagnostic.open_float, { noremap = true, silent = true, desc = "显示诊断" })
      map("n", "[d", vim.diagnostic.goto_prev, { noremap = true, silent = true, desc = "上一个诊断" })
      map("n", "]d", vim.diagnostic.goto_next, { noremap = true, silent = true, desc = "下一个诊断" })
    end,
  },
}
