-- Simple functions that just navigate to the first of a filetype in the same
-- directory as your current buffer. Intended for switching files quickly in
-- lwc
local M = {}

M.setup = function(opts)
  if not opts then
    opts = {}
  end
  vim.keymap.set('n', '<leader>j', function()
    local currentPath = vim.api.nvim_buf_get_name(0)
    local currentDir = vim.fn.fnamemodify(currentPath, ':h') -- Get the current directory
    local jsFiles = vim.fn.globpath(currentDir, '*.js', false, true) -- Find all .js files in the directory

    if #jsFiles > 0 then
      -- Open the first JavaScript file found
      vim.api.nvim_command('edit ' .. jsFiles[1])
    else
      print 'No JavaScript files found in the current directory.'
    end
  end, { desc = 'navigate to javascript file in same folder' })

  vim.keymap.set('n', '<leader>S', function()
    local currentPath = vim.api.nvim_buf_get_name(0)
    local currentDir = vim.fn.fnamemodify(currentPath, ':h') -- Get the current directory
    local cssFiles = vim.fn.globpath(currentDir, '*.css', false, true) -- Find all .css files in the directory

    if #cssFiles > 0 then
      -- Open the first css file found
      vim.api.nvim_command('edit ' .. cssFiles[1])
    else
      print 'No css files found in the current directory.'
    end
  end, { desc = 'navigate to css file in same folder' })

  vim.keymap.set('n', '<leader>m', function()
    local currentPath = vim.api.nvim_buf_get_name(0)
    local currentDir = vim.fn.fnamemodify(currentPath, ':h') -- Get the current directory
    local htmlFiles = vim.fn.globpath(currentDir, '*.html', false, true) -- Find all .html files in the directory

    if #htmlFiles > 0 then
      -- Open the first html file found
      vim.api.nvim_command('edit ' .. htmlFiles[1])
    else
      print 'No html files found in the current directory.'
    end
  end, { desc = 'navigate to html file in same folder' })
end

return M
