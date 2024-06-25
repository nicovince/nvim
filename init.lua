# Source legacy vimrc configuration
local vimrc = vim.fn.stdpath("config") .. "/legacy_vimrc.vim"
vim.cmd.source(vimrc)

require("CopilotChat").setup {
  debug = true, -- Enable debugging
  -- See Configuration section for rest
}
