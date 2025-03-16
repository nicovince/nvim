-- Disable copilot by default
vim.g.copilot_filetypes = {
  ["*"] = false,
}
-- explicitly request for copilot suggestions on Ctrl-j
vim.keymap.set('i', '<C-j>', '<Plug>(copilot-suggest)')
vim.keymap.set('i', '<C-h>', '<Plug>(copilot-previous)')
vim.keymap.set('i', '<C-l>', '<Plug>(copilot-next)')

-- lua function to set ft provided in arg to value provided in arg
function copilot_ft_enable(ft, value)
  vim.g.copilot_filetypes= {
    [ft] = value
  }
end

vim.api.nvim_create_user_command(
  'CopilotAutoSuggest',
  function()
    copilot_ft_enable(vim.bo.filetype, true)
  end,
  {bang = true, desc = "Enable Copilot auto suggestion"}
)

vim.api.nvim_create_user_command(
  'CopilotAutoSuggestOff',
  function()
    copilot_ft_enable(vim.bo.filetype, false)
  end,
  {bang = true, desc = "Disable Copilot auto suggestion"}
)
