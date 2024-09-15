local M = {}

-- Set commentstring for Apex code
M.setup = function()
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'apex',
    callback = function()
      vim.bo.commentstring = '// %s'
    end,
  })

  -- Add Apex as a filetype
  vim.filetype.add {
    extension = {
      cls = 'apex',
      apex = function(_, bufnr)
        vim.b[bufnr].commentstring = '//'
        return 'apex'
      end,
      trigger = 'apex',
    },
  }

  vim.filetype.add {
    extension = {
      cmp = 'html',
    },
  }
end

return M
