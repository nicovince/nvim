-- Source legacy vimrc configuration
local vimrc = vim.fn.stdpath("config") .. "/legacy_vimrc.vim"
vim.cmd.source(vimrc)

vim.cmd [[colorscheme vim]]
-- Show line number
vim.wo.number = true
-- Disable mouse
vim.o.mouse = ''

require("CopilotChat").setup {
  debug = true, -- Enable debugging
  -- See Configuration section for rest
}

require('copilot-usercfg')

-- fileteypes
vim.filetype.add({
  pattern = {[".*/.github/workflows/.*%.yml"] = "yaml.ghaction",}
})


-- command to toggle vim.diagnostic
-- The diagnostic is the left column and virtual text showing off after linters parse, or showing breakpoint.
vim.api.nvim_create_user_command(
  'ToggleDiagnostic',
  function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  end,
  {bang = true, desc ="Toggle diagnostic"}
)

-- Debugger config
require('nvim-dap-usercfg')

-- linter config
require('nvim-lint-usercfg')
