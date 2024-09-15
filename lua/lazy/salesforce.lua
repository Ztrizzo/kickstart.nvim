local M = {}

M.config = {
  'jonathanmorris180/salesforce.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },

  config = function()
    require('salesforce').setup {
      debug = {
        to_file = true,
      },
    }
    -- require('salesforce.org_manager'):get_default_alias()
    -- require('salesforce.org_manager'):get_org_info()
  end,
  keys = {
    {
      '<leader>oT',
      function()
        require('salesforce.test_runner'):execute_current_class()
      end,
      desc = 'Salesforce [O]rg execute all [T]ests in class',
    },
    {
      '<leader>ot',
      function()
        require('salesforce.test_runner'):execute_current_method()
      end,
      desc = 'Salesforce [O]rg execute [T]est at cursor',
    },
    {
      '<leader>oa',
      function()
        require('salesforce.component_generator'):create_apex()
      end,
      desc = 'Salesforce [O]rg create Apex',
    },
    {
      '<leader>ol',
      function()
        require('salesforce.component_generator'):create_lightning_component()
      end,
      desc = 'Salesforce [O]rg create Lightning Component',
    },
    {
      '<leader>or',
      function()
        require('salesforce.file_manager'):pull_from_org()
      end,
      desc = '[O]rg [R]etrieve',
    },
    {
      '<leader>od',
      function()
        require('salesforce.org_manager'):set_default_org()
      end,
      desc = '[O]rg set [D]efault',
    },
    {
      '<leader>op',
      function()
        vim.cmd ':w'
        require('salesforce.file_manager'):push_to_org()
      end,
      desc = '[O]rg [P]ush',
    },
    {
      '<leader>oo',
      function()
        vim.fn.jobstart 'sf org open'
      end,
      desc = '[O]rg [O]pen',
    },
  },
}

return M
