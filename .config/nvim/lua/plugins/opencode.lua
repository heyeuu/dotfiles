return {
  "nickjvandyke/opencode.nvim",
  version = "*", -- 获取最新稳定版
  dependencies = {
    {
      "folke/snacks.nvim",
      opts = {
        -- lazy.nvim 会自动将这里的配置与 LazyVim 内置的 snacks 配置合并
        input = {},
        picker = {
          actions = {
            opencode_send = function(...)
              return require("opencode").snacks_picker_send(...)
            end,
          },
          win = {
            input = {
              keys = {
                -- 在 snacks 的输入框中，按 Alt+a 发送内容给 opencode
                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
              },
            },
          },
        },
      },
    },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- 如果你需要配置 opencode，写在这里
    }

    vim.o.autoread = true -- 必须开启，以便 AI 修改文件后自动刷新

    -- 快捷键设置
    -- <C-a>: 询问 AI
    vim.keymap.set({ "n", "x" }, "<C-a>", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "Ask opencode…" })
    -- <C-x>: 调出动作菜单
    vim.keymap.set({ "n", "x" }, "<C-x>", function()
      require("opencode").select()
    end, { desc = "Execute opencode action…" })
    -- <C-.>: 切换 opencode 侧边栏/终端
    vim.keymap.set({ "n", "t" }, "<C-.>", function()
      require("opencode").toggle()
    end, { desc = "Toggle opencode" })

    -- Vim 风格的范围操作
    vim.keymap.set({ "n", "x" }, "go", function()
      return require("opencode").operator("@this ")
    end, { desc = "Add range to opencode", expr = true })
    vim.keymap.set("n", "goo", function()
      return require("opencode").operator("@this ") .. "_"
    end, { desc = "Add line to opencode", expr = true })

    -- 滚动 AI 消息记录
    vim.keymap.set("n", "<S-C-u>", function()
      require("opencode").command("session.half.page.up")
    end, { desc = "Scroll opencode up" })
    vim.keymap.set("n", "<S-C-d>", function()
      require("opencode").command("session.half.page.down")
    end, { desc = "Scroll opencode down" })

    -- 原生 Neovim 中，<C-a> 是数字加1，<C-x> 是数字减1。
    -- 因为上面把这两个快捷键分配给 opencode 了，为了保留原生功能，这里将它们转移到了 + 和 - 键上。
    vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
    vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
  end,
}
