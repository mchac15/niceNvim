return {
  'NLKNguyen/papercolor-theme',
  lazy = false,
  priority = 1000,
  config = function()
    -- Load the colorscheme
    vim.cmd [[colorscheme PaperColor]]

    -- Toggle background transparency
    local bg_transparent = true

    local toggle_transparency = function()
      bg_transparent = not bg_transparent
      if bg_transparent then
        vim.cmd [[highlight Normal guibg=NONE ctermbg=NONE]]
        vim.cmd [[highlight NonText guibg=NONE ctermbg=NONE]]
      else
        vim.cmd [[colorscheme PaperColor]]
      end
    end

    vim.keymap.set('n', '<leader>bg', toggle_transparency, { noremap = true, silent = true })
  end,
}
