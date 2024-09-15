local M = {}

M.setup = function()
  -- Load salesforce org info when nvim opens
  vim.api.nvim_create_autocmd('VimEnter', {
    group = vim.api.nvim_create_augroup('salesforce', { clear = true }),
    callback = function()
      require('salesforce.org_manager'):get_org_info()
    end,
  })
end

return M
