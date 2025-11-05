-- Main theme configuration
local opt = {
  flavour = 'mocha', -- mocha, frappe, macchiato, latte
  background = { -- :h background
    light = 'latte',
    dark = 'mocha',
  },
  transparent_background = false, -- disables setting the background color
  show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
  term_colors = false, -- sets terminal colors (e.g., `g:terminal_color_0`)
  dim_inactive = {
    enabled = false, -- dims the background color of inactive windows
    shade = 'dark',
    percentage = 0.15, -- percentage of the shade to apply to the inactive window
  },
  no_italic = false, -- Force no italic
  no_bold = false, -- Force no bold
  no_underline = false, -- Force no underline
  styles = { -- Handles the styles of general hi groups
    comments = { 'italic' }, -- Change the style of comments
    conditionals = { 'italic' },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  color_overrides = {},
  custom_highlights = {},
  default_integrations = true,
  integrations = {
    cmp = true,
    gitsigns = true,
    treesitter = true,
    notify = false,
    mini = {
      enabled = true,
      indentscope_color = '',
    },
    mason = true,
    neotree = true,
  },
}

return {
  'catppuccin/nvim', -- Plugin name
  lazy = false, -- Don't lazy load this plugin
  name = 'catppuccin', -- Plugin name for reference
  priority = 1000, -- Set priority (optional)
  config = function()
    require('catppuccin').setup(opt) -- Apply the theme with the provided options
    vim.cmd.colorscheme 'catppuccin' -- Apply the colorscheme
  end,
}
