return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'jayp0521/mason-null-ls.nvim', -- ensure dependencies are installed
  },
  config = function()
    local null_ls = require 'null-ls'
    local formatting = null_ls.builtins.formatting -- to setup formatters
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters

    -- Formatters & linters for mason to install
    require('mason-null-ls').setup {
      ensure_installed = {
        'prettier', -- ts/js formatter
        'stylua', -- lua formatter
        'eslint_d', -- ts/js linter
        'shfmt', -- Shell formatter
        'checkmake', -- linter for Makefiles
        'ruff', -- Python linter and formatter
        'google-java-format', -- Java formatter
        'clang-format', -- C/C++ formatter
        'goimports', -- Go formatter (better than gofmt as it also handles imports)
        'gofumpt', -- Stricter Go formatter (optional, more opinionated than gofmt)
      },
      automatic_installation = true,
    }

    local sources = {
      diagnostics.checkmake,
      formatting.prettier.with { filetypes = { 'html', 'json', 'yaml', 'markdown', 'javascript', 'typescript' } },
      formatting.stylua,
      formatting.shfmt.with { args = { '-i', '4' } },
      formatting.terraform_fmt,
      require('none-ls.formatting.ruff').with { extra_args = { '--extend-select', 'I' } },
      require 'none-ls.formatting.ruff_format',

      -- Java Formatter
      formatting.google_java_format,

      -- C Formatter
      formatting.clang_format.with {
        filetypes = { 'c', 'cpp', 'glsl', 'hlsl' },
        extra_args = {
          '--style={BasedOnStyle: Google, IndentWidth: 4, ColumnLimit: 100}',
        },
      },

      -- Go Formatters
      formatting.goimports, -- Formats code and organizes imports
      formatting.gofumpt, -- More strict formatting (optional)
    }

    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    null_ls.setup {
      -- debug = true, -- Enable debug mode. Inspect logs with :NullLsLog.
      sources = sources,
      -- you can reuse a shared lspconfig on_attach callback here
      on_attach = function(client, bufnr)
        if client.supports_method 'textDocument/formatting' then
          local opts = { noremap = true, silent = true, buffer = bufnr }
          -- Change "<leader>f" to your preferred keybinding
          vim.keymap.set('n', '<leader>gf', function()
            vim.lsp.buf.format { async = true }
          end, opts)
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format { async = false }
            end,
          })
        end
      end,
    }
  end,
}
