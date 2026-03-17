return {
  {
    "Civitasv/cmake-tools.nvim",
    lazy = true,
    ft = { "cmake" },
    opts = {
      cmake_regenerate_on_save = true,
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "cmake" })
      end
    end,
  },
}
