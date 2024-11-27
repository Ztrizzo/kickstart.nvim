
local M = {}

M.config = {
  'xixiaofinland/sf.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'ibhagwan/fzf-lua',
  },

  config = function()
    local Sf = require('sf');
    Sf.setup({
      -- Unless you want to customize, no need to copy-paste any of these
      -- They are applied automatically

      -- This plugin has many default hotkey mappings supplied
      -- This flag enable/disable these hotkeys defined
      -- It's highly recommended to set this to `false` and define your own key mappings
      -- Set to `true` if you don't mind any potential key mapping conflicts with your own
      enable_hotkeys = false,

      -- this setting takes effect only when You have "enable_hotkeys = true"(i.e. use default supplied hotkeys).
      -- In the default hotkeys, some hotkeys are on "project level" thus always enabled. Examples: "set default org", "fetch org info".
      -- Other hotkeys are enabled when only metadata filetypes are loaded in the current buffer. Example: "push/retrieve current metadata file"
      -- This list defines what metadata filetypes have the "other hotkeys" enabled.
      -- For example, if you want to push/retrieve css files, it needs to be added into this list.
      hotkeys_in_filetypes = {
        "apex", "sosl", "soql", "javascript", "html"
      },

      -- When Nvim is initiated, the sf org list is automatically fetched and target_org is set (if available) by `:SF org fetchList`
      -- You can set it to `false` and have a manual control
      fetch_org_list_at_nvim_start = true,

      -- Define what metadata to be listed in `list_md_to_retrieve()` (<leader>ml)
      -- Salesforce has numerous metadata types. We narrow down the scope of `list_md_to_retrieve()`.
      types_to_retrieve = {
        "ApexClass",
        "ApexTrigger",
        "StaticResource",
        "LightningComponentBundle"
      },

      -- Configuration for the integrated terminal
      term_config = {
        blend = 10,     -- background transparency: 0 is fully opaque; 100 is fully transparent
        dimensions = {
          height = 0.4, -- proportional of the editor height. 0.4 means 40%.
          width = 0.8,  -- proportional of the editor width. 0.8 means 80%.
          x = 0.5,      -- starting position of width. Details in `get_dimension()` in raw_term.lua source code.
          y = 0.9,      -- starting position of height. Details in `get_dimension()` in raw_term.lua source code.
        },
      },

      -- the sf project metadata folder, update this in case you diverged from the default sf folder structure
      default_dir = '/force-app/main/default/',

      -- the folder this plugin uses to store intermediate data. It's under the sf project root directory.
      plugin_folder_name = '/sf_cache/',

      -- after the test running with code coverage completes, display uncovered line sign automatically.
      -- you can set it to `false`, then manually run toggle_sign command.
      auto_display_code_sign = true,

      -- code coverage sign icon colors
      code_sign_highlight = {
        covered = { fg = "#b7f071" }, -- set `fg = ""` to disable this sign icon
        uncovered = { fg = "#f07178" }, -- set `fg = ""` to disable this sign icon
      },
    })


    -- all your key definitions put below
    vim.keymap.set('n', '<leader>od', Sf.set_target_org, { desc = "set default org" })
    vim.keymap.set('n', '<leader>oc', Sf.toggle_term, { desc = "toggle terminal" })
    vim.keymap.set('n', '<leader>op', Sf.save_and_push, { desc = "save and push" })
    vim.keymap.set('n', '<leader>or', Sf.retrieve, { desc = "retrieve current file" })
    vim.keymap.set('n', '<leader>ot', Sf.run_current_test, { desc = "run test under cursor" })
    vim.keymap.set('n', '<leader>oT', Sf.run_all_tests_in_this_file, { desc = "run all tests in file" })
    vim.keymap.set('n', '<leader>oD', Sf.diff_in_org, { desc = "diff in org" })
    vim.keymap.set('n', '<leader>ol', Sf.create_lwc_bundle, { desc = "create lightning bundle" })
    vim.keymap.set('n', '<leader>oa', Sf.create_apex_class, { desc = "create Apex class" })
    vim.keymap.set('n', '<leader>oo', Sf.org_open, { desc = "open org" })
    vim.keymap.set('n', '<leader>oO', Sf.org_open_current_file, { desc = "open org" })
    vim.keymap.set('n', '<leader>oq', Sf.run_query, { desc = "run query in buffer" })
    vim.keymap.set('n', '<leader>oL', Sf.pull_log, { desc = "pull logs" })
    vim.keymap.set('n', '<leader>om', Sf.pull_md_json, { desc = "pull metadata list" })
    vim.keymap.set('n', '<leader>og', Sf.create_trigger, { desc = "Create Apex Trigger" })
    vim.keymap.set('n', '<leader>oC', function() os.execute('sf org open --target-org "Quinn Copado Org"') end, { desc = "Open Copado Org" })

  end,
  -- keys = {
  --   {
  --     '<leader>oT',
  --     function()
  --       require('salesforce.test_runner'):execute_current_class()
  --     end,
  --     desc = 'Salesforce [O]rg execute all [T]ests in class',
  --   },
  --   {
  --     '<leader>ot',
  --     function()
  --       require('salesforce.test_runner'):execute_current_method()
  --     end,
  --     desc = 'Salesforce [O]rg execute [T]est at cursor',
  --   },
  --   {
  --     '<leader>oa',
  --     function()
  --       require('salesforce.component_generator'):create_apex()
  --     end,
  --     desc = 'Salesforce [O]rg create Apex',
  --   },
  --   {
  --     '<leader>ol',
  --     function()
  --       require('salesforce.component_generator'):create_lightning_component()
  --     end,
  --     desc = 'Salesforce [O]rg create Lightning Component',
  --   },
  --   {
  --     '<leader>or',
  --     function()
  --       require('salesforce.file_manager'):pull_from_org()
  --     end,
  --     desc = '[O]rg [R]etrieve',
  --   },
  --   {
  --     '<leader>od',
  --     function()
  --       require('salesforce.org_manager'):set_default_org()
  --     end,
  --     desc = '[O]rg set [D]efault',
  --   },
  --   {
  --     '<leader>op',
  --     function()
  --       vim.cmd ':wall'
  --       require('salesforce.file_manager'):push_to_org()
  --     end,
  --     desc = '[O]rg [P]ush',
  --   },
  --   {
  --     '<leader>oo',
  --     function()
  --       vim.fn.jobstart 'sf org open'
  --     end,
  --     desc = '[O]rg [O]pen',
  --   },
  --   {
  --     '<leader>oD',
  --     function()
  --       require('salesforce.diff'):diff_with_org()
  --     end,
  --     desc = '[O]rg [D]iff',
  --   },
  -- },
}

return M
