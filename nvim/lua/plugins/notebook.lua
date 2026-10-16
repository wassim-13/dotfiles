return {
  {
    "GCBallesteros/jupytext.nvim",
    lazy = false,
    opts = {
      style = "percent",
      output_extension = "auto",
      force_ft = nil,
    },
  },
  {
    "Vigemus/iron.nvim",
    keys = {
      { "<leader>rs", "<cmd>IronRepl<cr>", desc = "Toggle Notebook REPL" },
      {
        "<leader>rr",
        function()
          require("iron.core").send_code_block(false)
        end,
        desc = "Run Cell",
      },
      {
        "<leader>rn",
        function()
          require("iron.core").send_code_block(true)
        end,
        desc = "Run Cell & Move Next",
      },
      {
        "<leader>rl",
        function()
          require("iron.core").send_line()
        end,
        desc = "Run Line",
      },
    },
    config = function()
      require("iron.core").setup({
        config = {
          repl_definition = {
            python = {
              command = { "ipython", "--no-autoindent" },
              format = require("iron.fts.common").bracketed_paste_python,
            },
          },
          repl_open_cmd = "vertical botright 80 split",
        },
      })
    end,
  },
}
