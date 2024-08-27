function ColorMyPencils(color)
  color = color or "rose-pine"
  vim.cmd.colorscheme(color)
  -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
  { "ellisonleao/gruvbox.nvim" },
  { "catppuccin/nvim", name = "catppuccin" },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        -- disable_background = true,

        before_highlight = function(group, highlight, palette)
          if highlight.fg == palette.pine then
            highlight.fg = "#68998a"
          end
          if highlight.fg == palette.gold then
            highlight.fg = "#ffaf87"
          end
        end,
      })
      -- ColorMyPencils()
    end,
  },

  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "rose-pine-moon",
  --   },
  -- },
}
