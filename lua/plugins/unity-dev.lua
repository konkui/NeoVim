-- Unity C# + xLua 开发配置
return {
  -- =====================
  -- C# (OmniSharp) 配置
  -- =====================
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- OmniSharp: C# LSP，Mason 会自动安装
        omnisharp = {
          -- 如果你的 .sln 不在默认位置，可以手动指定
          -- cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
          settings = {
            FormattingOptions = {
              EnableEditorConfigSupport = true,
              OrganizeImports = true,
            },
            RoslynExtensionsOptions = {
              EnableAnalyzersSupport = true,
              EnableImportCompletion = true,
            },
          },
          -- Unity 项目通常需要从 .sln 所在目录启动
          root_dir = function(fname)
            local lspconfig = require("lspconfig")
            -- 优先找 .sln 文件
            return lspconfig.util.root_pattern("*.sln")(fname)
              or lspconfig.util.root_pattern("*.csproj", ".git")(fname)
          end,
        },

        -- Lua LSP
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                version = "Lua 5.3", -- xLua 默认用 Lua 5.3
              },
              diagnostics = {
                -- 识别 Unity xLua 常见全局变量
                globals = {
                  "CS",        -- xLua 的 C# 命名空间访问
                  "typeof",    -- xLua 的 typeof
                  "xlua",      -- xLua 模块
                  "UnityEngine",
                },
              },
              workspace = {
                -- 让 lua_ls 识别你项目中的 Lua 文件
                library = {},
                checkThirdParty = false,
              },
              telemetry = { enable = false },
            },
          },
        },
      },
    },
  },

  -- =====================
  -- Mason: 确保安装所需工具
  -- =====================
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "omnisharp",         -- C# LSP
        "lua-language-server", -- Lua LSP
        "stylua",            -- Lua 格式化
        -- "csharpier",      -- C# 格式化（可选）
      },
    },
  },

  -- =====================
  -- Treesitter: 确保语法高亮
  -- =====================
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "c_sharp",
        "lua",
      },
    },
  },

  -- =====================
  -- 格式化配置（可选）
  -- =====================
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        -- cs = { "csharpier" }, -- 取消注释启用 C# 格式化
      },
    },
  },
}
