return {
  'xemptuous/sqlua.nvim',
  lazy = false, -- Force it to load immediately
  config = function()
    require('sqlua').setup()
  end,
}
