vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4

require('utils')
local path = vim.fn.expand('%:p')
if IsZephyr(path) or IsLinux(path) then
  vim.opt_local.expandtab = false
  vim.opt_local.shiftwidth = 8
  vim.opt_local.tabstop = 8
elseif IsSiema(path) then
  vim.opt_local.expandtab = true
  vim.opt_local.shiftwidth = 4
  vim.opt_local.tabstop = 4
end

if IsZephyr(path) then
  vim.opt_local.textwidth = 100
end

-- indent argument split on multiple lines aligned on the first arg
-- func(arg1,
--      arg2);
vim.opt_local.cinoptions:append('(0')
-- indent switch case statement like this :
-- switch(x)
-- {
-- case 1:
--   foo();
-- default:
-- }
vim.opt_local.cinoptions:append(':0')

vim.api.nvim_create_user_command(
  'CHdrGuard',
  function()
    local filename = vim.fn.expand('%:t')
    local guard = '__' .. string.gsub(string.upper(filename), '%p', '_') .. '__'
    local cursor = vim.api.nvim_win_get_cursor(0)
    local pos = cursor[2]
    local line = cursor[1]
    local hdr_lines = { "#ifndef " .. guard,
      "#define " .. guard,
    }
    local footer_lines = {"#endif /* " .. guard .. " */" }
    vim.api.nvim_buf_set_lines(0, 0, 0, false, hdr_lines)
    vim.api.nvim_buf_set_lines(0, -1, -1, false, footer_lines)
    vim.api.nvim_win_set_cursor(0, {line + 1, pos})
  end,
  { bang = true, nargs = 0, desc = "Two voices on staff"}
)
