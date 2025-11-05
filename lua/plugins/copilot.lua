return {
  -- Copilot and Copilot completion source
  {
    'github/copilot.vim',
    config = function()
      -- Optional setup for Copilot, if needed
      vim.g.copilot_no_tab_map = true -- Disable the default tab mapping (you can map it manually if desired)
    end,
  },
  {
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup()
    end,
  },
}
