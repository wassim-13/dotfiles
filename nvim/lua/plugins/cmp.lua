return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = {
        { name = "nvim_lsp" },
      }
      return opts
    end,
  },
}
