return {
  "yetone/avante.nvim",
  -- Windows 和 Linux/Mac 的构建命令
  build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    or "make",
  event = "VeryLazy",
  version = false,
  opts = {
    -- 1. 这里要改为 deepseek 才能让它生效
    provider = "kimi-cli",

    -- 2. 关键修正：这里必须叫 vendors，不能叫 providers
    vendors = {
      -- DeepSeek 配置
      deepseek = {
        __inherited_from = "openai",
        api_key_name = "DEEPSEEK_API_KEY",
        endpoint = "https://api.deepseek.com",
        model = "deepseek-chat", -- V3 模型
        timeout = 30000,
        temperature = 0,
        max_tokens = 8192, -- DeepSeek V3 最大输出支持 8K，可以稍微改大一点
      },

      moonshot = {
        __inherited_from = "openai",
        api_key_name = "MOONSHOT_API_KEY",
        endpoint = "https://api.moonshot.ai/v1",
        model = "kimi-k2-0711-preview",
        timeout = 30000, -- 超时时间（毫秒）
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 8196,
        },
      },
      gemini = {
        model = "gemini-3-flash-preview",
        timeout = 30000, -- 超时时间（毫秒）
        max_tokens = 8192,
      },
    }, -- 定义 ACP 提供商配置
    acp_providers = {
      ["kimi-cli"] = {
        command = "kimi",
        args = { "acp" },
      },
    },
    mode = "agentic",
    behaviour = {
      auto_apply_diffs = false, -- 建议设为 false，修改前让你确认
    },
  },

  -- 依赖项部分保持不变
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "echasnovski/mini.pick",
    "nvim-telescope/telescope.nvim",
    "hrsh7th/nvim-cmp",
    "ibhagwan/fzf-lua",
    "nvim-tree/nvim-web-devicons",
    "zbirenbaum/copilot.lua",
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = { insert_mode = true },
          use_absolute_path = true,
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = { file_types = { "markdown", "Avante" } },
      ft = { "markdown", "Avante" },
    },
  },
}
