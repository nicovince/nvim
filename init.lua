-- vim: tabstop=2 shiftwidth=2 expandtab

-- Source legacy vimrc configuration
local vimrc = vim.fn.stdpath("config") .. "/legacy_vimrc.vim"
vim.cmd.source(vimrc)

require("CopilotChat").setup {
  debug = true, -- Enable debugging
  -- See Configuration section for rest
}
-- Disable copilot by default
vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Disable Copilot by default on startup",
  command = "Copilot disable",
})

-- Disable mouse
vim.o.mouse = ''
