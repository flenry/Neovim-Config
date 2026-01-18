return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    { 'folke/snacks.nvim', opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      provider = {
        enabled = 'tmux',
        tmux = {
          options = '-h -l 80', -- Horizontal split, 80 columns wide
        },
      },
    }

    -- Required for buffer auto-reload when opencode edits files
    vim.o.autoread = true
    vim.o.updatetime = 300 -- Faster CursorHold trigger (default 4000ms)

    -- Auto-reload files when they change on disk
    vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
      pattern = '*',
      command = 'if mode() != "c" | checktime | endif',
    })

    -- Notify when file changes and refresh Neo-tree
    vim.api.nvim_create_autocmd('FileChangedShellPost', {
      pattern = '*',
      callback = function()
        vim.notify('File changed on disk. Buffer reloaded.', vim.log.levels.INFO)
        -- Refresh Neo-tree if it's open
        local ok, _ = pcall(require, 'neo-tree')
        if ok then
          require('neo-tree.sources.manager').refresh 'filesystem'
        end
      end,
    })

    -- Refresh Neo-tree when files are created/deleted/renamed by opencode
    vim.api.nvim_create_autocmd('User', {
      pattern = 'OpencodeEvent:file.edited',
      callback = function()
        local ok, _ = pcall(require, 'neo-tree')
        if ok then
          require('neo-tree.sources.manager').refresh 'filesystem'
        end
      end,
    })

    -- Keymaps
    vim.keymap.set({ 'n', 'x' }, '<C-a>', function()
      require('opencode').ask('@this: ', { submit = true })
    end, { desc = 'Ask opencode' })
    vim.keymap.set({ 'n', 'x' }, '<C-x>', function()
      require('opencode').select()
    end, { desc = 'Execute opencode action…' })
    vim.keymap.set({ 'n', 'x' }, 'ga', function()
      require('opencode').prompt '@this'
    end, { desc = 'Add to opencode' })
    vim.keymap.set({ 'n', 't' }, '<C-.>', function()
      require('opencode').toggle()
    end, { desc = 'Toggle opencode' })
    vim.keymap.set('n', '<S-C-u>', function()
      require('opencode').command 'session.half.page.up'
    end, { desc = 'opencode half page up' })
    vim.keymap.set('n', '<S-C-d>', function()
      require('opencode').command 'session.half.page.down'
    end, { desc = 'opencode half page down' })
    -- Remap increment/decrement since <C-a> and <C-x> are taken
    vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment', noremap = true })
    vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement', noremap = true })
  end,
}
