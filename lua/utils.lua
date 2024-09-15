P = function(value)
  print(vim.inspect(value))
  return value
end

-- keymapping for executing your current buffer
vim.keymap.set('n', '<leader><leader>x', function()
  vim.api.nvim_command ':messages clear'
  vim.api.nvim_command ':w'
  vim.api.nvim_command ':source %'
end)
