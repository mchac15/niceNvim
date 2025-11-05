-- plugins/dadbod.lua

return {
  'tpope/vim-dadbod',
  dependencies = {
    'kristijanhusak/vim-dadbod-ui',         -- Optional UI for managing DBs
    'kristijanhusak/vim-dadbod-completion', -- Optional autocompletion
  },
  lazy = false, -- Ensure it loads immediately
  config = function()
    -- Enable db UI (Optional, for interactive browsing)
    vim.g.db_ui = 1

    -- Define the connection string for Oracle (Update with your details)
    vim.g.db_ui_connect_string = 'oracle://C##DB2024:DB2024@cs322-db.epfl.ch:1521/ORCLCDB'

    -- Ensure DB is connected using the provided connection string
    vim.g.db_ui_save_on_connect = 1  -- Automatically save connection details

    -- Allow vim-dadbod to use the db connection on startup
    vim.g.db_ui_auto_connect = 1  -- Automatically connect on start

    -- Optional: Set Oracle client path (if using Oracle client libraries)
    vim.g.db_oracle_client_path = '/path/to/oracle/client'  -- Adjust if needed
  end,
}

