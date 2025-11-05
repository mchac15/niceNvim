-- Main debugger
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    {
      'rcarriga/nvim-dap-ui',
      lazy = false,
    },
    'nvim-neotest/nvim-nio',
    {
      'mfussenegger/nvim-dap-python',
      config = function()
        require('dap-python').setup '/home/matheo/.virtualenvs/neovim/bin/python'
      end,
    },
    {
      'leoluz/nvim-dap-go',
      ft = { 'go' },
      config = function()
        require('dap-go').setup()
      end,
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    dapui.setup {}

    -- DAP UI auto open/close
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    -- Function key mappings
    vim.keymap.set('n', '<F5>', dap.continue, {})
    vim.keymap.set('n', '<F10>', dap.step_over, {})
    vim.keymap.set('n', '<F11>', dap.step_into, {})
    vim.keymap.set('n', '<F12>', dap.step_out, {})

    -- DAP keymaps using your preferred scheme
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Add breakpoint at line' })
    vim.keymap.set('n', '<leader>dus', function()
      local widgets = require 'dap.ui.widgets'
      local sidebar = widgets.sidebar(widgets.scopes)
      sidebar.open()
    end, { desc = 'Open debugging sidebar' })

    -- Additional useful DAP keymaps
    vim.keymap.set('n', '<Leader>dB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Set conditional breakpoint' })
    vim.keymap.set('n', '<Leader>dlp', function()
      dap.set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
    end, { desc = 'Set log point' })
    vim.keymap.set('n', '<Leader>dr', dap.repl.open, { desc = 'Open DAP REPL' })
    vim.keymap.set('n', '<Leader>dl', dap.run_last, { desc = 'Run last debug session' })
    vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
      require('dap.ui.widgets').hover()
    end, { desc = 'DAP hover' })
    vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
      require('dap.ui.widgets').preview()
    end, { desc = 'DAP preview' })
    vim.keymap.set('n', '<Leader>df', function()
      local widgets = require 'dap.ui.widgets'
      widgets.centered_float(widgets.frames)
    end, { desc = 'Show frames' })

    -- C/C++ adapter configuration
    dap.adapters.cppdbg = {
      id = 'cppdbg',
      type = 'executable',
      command = '/home/matheo/cpptools-linux/extension/debugAdapters/bin/OpenDebugAD7',
    }

    -- C/C++ configurations
    dap.configurations.cpp = {
      {
        name = 'Launch file',
        type = 'cppdbg',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
      },
      {
        name = 'Launch file with argument',
        type = 'cppdbg',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        args = function()
          local args_str = vim.fn.input {
            prompt = 'Arguments: ',
          }
          return vim.split(args_str, ' +')
        end,
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
      },
      {
        name = 'Attach to gdbserver :1234',
        type = 'cppdbg',
        request = 'launch',
        MIMode = 'gdb',
        miDebuggerServerAddress = 'localhost:1234',
        miDebuggerPath = '/usr/bin/gdb',
        cwd = '${workspaceFolder}',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
      },
    }
    dap.configurations.c = dap.configurations.cpp
  end,
}
