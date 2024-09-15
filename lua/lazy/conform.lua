local M = {}

M.config = { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        local current_file_type = vim.bo.filetype
        if current_file_type == 'apex' then
          local status_code = os.execute 'npm run | grep -q prettier:singlefile'
          if status_code ~= 0 then
            -- Need to add the following script to your package.json
            -- "prettier:singlefile": "prettier --write"
            vim.notify('No npm prettier:singlefile command found in package.json', vim.log.levels.ERROR)
          else
            vim.notify('formatting apex', vim.log.levels.INFO)
            local current_path = vim.api.nvim_buf_get_name(0)
            local command = {
              'npm',
              'run',
              'prettier:singlefile',
              '--',
              current_path,
            }
            vim
              .system(
                command,
                nil,
                vim.schedule(function()
                  vim.notify('file formatted', vim.log.levels.INFO)
                  vim.cmd ':edit!'
                  vim.cmd ':redraw'
                end)
              )
              :wait()
          end
        else
          require('conform').format { async = true, lsp_fallback = true }
        end
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  },
}

return M
