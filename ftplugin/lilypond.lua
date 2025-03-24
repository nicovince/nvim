vim.api.nvim_create_user_command(
  'TwoVoices',
  function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local pos = cursor[2]
    local line = cursor[1]
    local current_indent = vim.fn.cindent(line)
    local indentation = string.rep(" ", current_indent)
    local nxt_indentation = string.rep(" ", current_indent + vim.opt_local.shiftwidth:get())
    local newlines = { indentation .. "<<",
      nxt_indentation .. "{}",
      nxt_indentation .. "\\\\",
      nxt_indentation .. "{}",
      indentation .. ">> |",
    }
    vim.api.nvim_buf_set_lines(0, line - 1, line - 1, false, newlines)
    col = current_indent + vim.opt_local.shiftwidth:get() + 1
    vim.api.nvim_win_set_cursor(0, {line + 1, col})
  end,
  { bang = true, nargs = 0, desc = "Two voices on staff"}
)
