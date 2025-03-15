-- General keymappings for debugging

vim.keymap.set('n', '<Leader>dc', function() require('dap').continue() end)
vim.keymap.set('n', '<Leader>dn', function() require('dap').step_over() end)
vim.keymap.set('n', '<Leader>ds', function() require('dap').step_into() end)
vim.keymap.set('n', '<Leader>df', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>db', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>dB', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>dlp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dP', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>dW', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>dS', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)

-- python debugger
-- Check if debugpy virtenv exists
-- It can be created with:
-- mkvirtualenv debugpy
-- pip install debugpy
if vim.fn.isdirectory(os.getenv("HOME") .. "/.virtualenvs/debugpy") then
  require("dap-python").setup("/home/nicolas/.virtualenvs/debugpy/bin/python")
end
