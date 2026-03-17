return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" }, -- 延迟加载：在打开文件时才加载，提高启动速度
  config = function()
    require("gitsigns").setup({
      -- 这里放官方推荐的快捷键配置
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- 撤回当前块 (你要的核心功能)
        map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset Hunk (撤回当前修改块)" })
        map("v", "<leader>hr", function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Reset Hunk (撤回选中行)" })

        -- 暂存当前块
        map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage Hunk (暂存当前修改块)" })
        map("v", "<leader>hs", function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Stage Hunk (暂存选中行)" })

        -- 预览当前修改了什么
        map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview Hunk (预览修改内容)" })

        -- 跳转到上一个/下一个修改点
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end, { desc = "Next Hunk (下一个修改点)" })

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end, { desc = "Prev Hunk (上一个修改点)" })
      end,
    })
  end,
}
