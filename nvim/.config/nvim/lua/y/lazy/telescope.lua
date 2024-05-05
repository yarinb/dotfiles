-- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin

local M = setmetatable({}, {
  __call = function(m, ...)
    return m.telescope(...)
  end,
})

function M.telescope(builtin, opts)
  local params = { builtin = builtin, opts = opts }
  return function()
    builtin = params.builtin
    opts = params.opts
    opts = vim.tbl_deep_extend("force", { cwd = Util.root() }, opts or {})
    if builtin == "files" then
      if
        vim.uv.fs_stat((vim.uv.cwd()) .. "/.git")
        and not vim.uv.fs_stat((vim.uv.cwd()) .. "/.ignore")
        and not vim.uv.fs_stat((vim.uv.cwd()) .. "/.rgignore")
      then
        if opts.show_untracked == nil then
          opts.show_untracked = true
        end
        builtin = "git_files"
      else
        builtin = "find_files"
      end
    end
    if opts.cwd and opts.cwd ~= vim.uv.cwd() then
      local function open_cwd_dir()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        M.telescope(
          params.builtin,
          vim.tbl_deep_extend("force", {}, params.opts or {}, { cwd = false, default_text = line })
        )()
      end
      ---@diagnostic disable-next-line: inject-field
      opts.attach_mappings = function(_, map)
        -- opts.desc is overridden by telescope, until it's changed there is this fix
        map("i", "<a-c>", open_cwd_dir, { desc = "Open cwd Directory" })
        return true
      end
    end

    require("telescope.builtin")[builtin](opts)
  end
end

return {
    { -- Fuzzy Finder (files, lsp, etc)
      'nvim-telescope/telescope.nvim',
      event = 'VimEnter',
      branch = '0.1.x',
      dependencies = {
        'nvim-lua/plenary.nvim',
        { -- If encountering errors, see telescope-fzf-native README for installation instructions
          'nvim-telescope/telescope-fzf-native.nvim',
  
          -- `build` is used to run some command when the plugin is installed/updated.
          -- This is only run then, not every time Neovim starts up.
          build = 'make',
  
          -- `cond` is a condition used to determine whether this plugin should be
          -- installed and loaded.
          cond = function()
            return vim.fn.executable 'make' == 1
          end,
        },
        { 'nvim-telescope/telescope-ui-select.nvim' },
  
        -- Useful for getting pretty icons, but requires a Nerd Font.
        { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
      },
      config = function()
        --
        -- Two important keymaps to use while in Telescope are:
        --  - Insert mode: <c-/>
        --  - Normal mode: ?
        --
        -- This opens a window that shows you all of the keymaps for the current
        -- Telescope picker. This is really useful to discover what Telescope can
        -- do as well as how to actually do it!
  
        -- [[ Configure Telescope ]]
        -- See `:help telescope` and `:help telescope.setup()`
        require('telescope').setup {
          --  All the info you're looking for is in `:help telescope.setup()`
          --
          -- defaults = {
          --   mappings = {
          --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
          --   },
          -- },
          pickers = {
            find_files = {
                hidden = true
              }
          },
          extensions = {
            ['ui-select'] = {
              require('telescope.themes').get_dropdown(),
            },
          },
        }
  
        -- Enable Telescope extensions if they are installed
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')
  
        -- See `:help telescope.builtin`
        local builtin = require 'telescope.builtin'
        vim.keymap.set('n', '<leader>,', "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", { desc = 'Switch Buffer' })
        vim.keymap.set('n', '<leader>:', "<cmd>Telescope command_history<cr>", { desc = 'Command History' })
        vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = 'Search by Grep' })
        vim.keymap.set('n', '<leader><space>', M.telescope('files'), { desc = 'Find Files' })
        -- find
        vim.keymap.set('n', '<leader>ff', M.telescope('files'), { desc = 'Find Files' })
        vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Find Files (git-files)' })
        vim.keymap.set('n', '<leader>fb', "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", { desc = 'Buffers' })
        vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Recent Files' })
        vim.keymap.set('n', '<leader>fR', M.telescope('oldfiles', { cwd = vim.uv.cwd() }), { desc = 'Recent Files (cwd)' })
        --git
        vim.keymap.set('n', '<leader>gc', "<cmd>Telescope git_commits<CR>", { desc = 'Git Commits' })
        vim.keymap.set('n', '<leader>gs', "<cmd>Telescope git_status<CR>", { desc = "Git Status" })

        vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Search Help' })
        vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Search Keymaps' })
        vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Word (Root Dir)' })
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Search by Grep' })
        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Diagnostics' })
        vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Search Resume' })
        
        
  
        -- Slightly advanced example of overriding default behavior and theme
        vim.keymap.set('n', '<leader>sb', function()
          -- You can pass additional configuration to Telescope to change the theme, layout, etc.
          builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
          })
        end, { desc = 'Fuzzily search in current buffer' })
  
        -- It's also possible to pass additional configuration options.
        --  See `:help telescope.builtin.live_grep()` for information about particular keys
        vim.keymap.set('n', '<leader>s/', function()
          builtin.live_grep {
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Files',
          }
        end, { desc = '[S]earch [/] in Open Files' })
  
        -- Shortcut for searching your Neovim configuration files
        vim.keymap.set('n', '<leader>fc', function()
          builtin.find_files { cwd = vim.fn.stdpath 'config' }
        end, { desc = 'Find Config File' })
      end,
    },
  }
  -- vim: ts=2 sts=2 sw=2 et
  
