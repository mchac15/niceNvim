return {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
  config = function()
    require('barbar').setup {} -- Ensure Barbar is initialized

    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }

    -- Move to previous/next buffer
    map('n', '<leader>bn', '<Cmd>BufferPrevious<CR>', opts) -- Use <leader>bn instead of gm
    map('n', '<leader>bp', '<Cmd>BufferNext<CR>', opts) -- Use <leader>bp instead of gt
    map('n', '<leader>bc', '<Cmd>BufferClose<CR>', opts) -- Close buffer
  end,
  version = '^1.0.0', -- only update when a new 1.x version is released
}
