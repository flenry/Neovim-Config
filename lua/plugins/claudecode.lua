return {
  'coder/claudecode.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('claudecode').setup {
      auto_start = true, -- Start WebSocket server automatically
      terminal = {
        split_side = 'right',
        split_width_percentage = 0.4,
      },
    }

    -- Send selection to Claude in tmux
    vim.keymap.set('v', '<leader>as', function()
      if not vim.env.TMUX then
        vim.notify('Not in tmux', vim.log.levels.WARN)
        return
      end

      -- Get selection info
      local start_line = vim.fn.line 'v'
      local end_line = vim.fn.line '.'
      if start_line > end_line then
        start_line, end_line = end_line, start_line
      end
      local file_path = vim.fn.expand '%:p'
      local message = string.format('%s:%d-%d', file_path, start_line, end_line)

      -- Check if Claude pane exists
      local panes = vim.fn.system "tmux list-panes -F '#{pane_id}:#{pane_current_command}'"
      local claude_pane = nil
      for line in panes:gmatch '[^\n]+' do
        if line:find 'claude' then
          claude_pane = line:match '^(%%[^:]+)'
          break
        end
      end

      if claude_pane then
        -- Send to existing Claude pane
        vim.fn.system(string.format('tmux send-keys -t %s %q', claude_pane, message))
      else
        -- Open new pane with Claude and the file reference
        vim.fn.system(string.format('tmux split-window -h -p 40 "claude \\"%s\\""', message))
      end

      -- Exit visual mode
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
    end, { desc = '[A]I [S]end selection to Claude', silent = true })

    -- Open Claude Code in a tmux pane on the right
    vim.keymap.set('n', '<leader>ac', function()
      -- Check if we're in tmux
      if vim.env.TMUX then
        -- Check if a Claude pane already exists
        local panes = vim.fn.system "tmux list-panes -F '#{pane_id}:#{pane_current_command}'"
        local claude_running = panes:find 'claude'

        if claude_running then
          -- Toggle to the Claude pane
          vim.fn.system 'tmux select-pane -R'
        else
          -- Create a new pane on the right and run claude
          vim.fn.system 'tmux split-window -h -p 40 "claude"'
        end
      else
        -- Not in tmux, use built-in terminal
        vim.cmd 'ClaudeCode'
      end
    end, { desc = '[A]I [T]mux pane', silent = true })
  end,
}
