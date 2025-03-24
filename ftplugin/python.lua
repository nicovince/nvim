require('utils')

vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true

function setup_python_cfg()
  if IsZephyr() then
    vim.opt_local.textwidth = 100
  end
end

setup_python_cfg()
