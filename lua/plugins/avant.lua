return {
  "yetone/avante.nvim",
  -- Windows 和 Linux/Mac 的构建命令
  build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" or
      "make",
  event = "VeryLazy",
  version = false,
  opts = {
    -- 1. 这里要改为 deepseek 才能让它生效
    provider = "deepseek",

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

      -- 如果你想保留 Moonshot (Kimi)，也要放在 vendors 里
      moonshot = {
        __inherited_from = "openai",
        api_key_name = "MOONSHOT_API_KEY", -- 确保你有这个环境变量
        endpoint = "https://api.moonshot.ai/v1",
        model = "kimi-latest",             -- 建议用 latest 或具体版本号
        timeout = 30000,
        temperature = 0.3,
        max_tokens = 4096,
      },
    },

    -- 3. 关于 Claude：
    -- Claude 是 Avante 的内置支持项。如果你只是想配置它，
    -- 通常不需要在 vendors 里重写，除非你要覆盖默认行为。
    -- 如果你想保留 Claude 的自定义配置，请查阅官方文档关于 `claude` 字段的直接配置。
    claude = {
      endpoint = "https://api.anthropic.com",
      model = "claude-3-5-sonnet-20241022", -- 修正为目前最强的 3.5 Sonnet
      temperature = 0,
      max_tokens = 8192,
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
