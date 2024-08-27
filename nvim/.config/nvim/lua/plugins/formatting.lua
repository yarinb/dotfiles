return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "sql-formatter")
    end,
  },
  -- {
  --   "nvimtools/none-ls.nvim",
  --   optional = true,
  --   opts = function(_, opts)
  --     local nls = require("null-ls")
  --     opts.sources = opts.sources or {}
  --     table.insert(opts.sources, nls.builtins.formatting.black)
  --   end,
  -- },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ["sql"] = { "sql_formatter" },
      },
      formatters = {
        ["sql_formatter"] = {
          prepend_args = { "-c", "/Users/yarinbenado/.config/sql-formatter/config.json" },
        },
      },
    },
  },
}
