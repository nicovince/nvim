-- Source legacy vimrc configuration
local vimrc = vim.fn.stdpath("config") .. "/legacy_vimrc.vim"
vim.cmd.source(vimrc)

vim.cmd.colorscheme('vim')
-- Disable mouse
vim.o.mouse = ''
-- when splitting the cursor is set on the right window
vim.o.splitright = true
-- Show matching opening parenthesis, curly braces, ...
vim.o.showmatch = true
-- two lines visible above and under cursor
vim.o.scrolloff = 2
-- status line (overriden with lightline)
vim.o.statusline = "%<%f %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%) %P"
vim.g.lightline = {
  colorscheme = 'one',
  component_function = {
    gitbranch = 'FugitiveStatusline'
  },
  component = {
    lineinfovirt = '%3l:%-2c%2V'
  },
  active = {
    left = { { 'mode', 'paste' }, { 'readonly', 'filename', 'modified' }, { 'gitbranch' } },
    right = { { 'lineinfovirt' }, { 'percent' }, { 'fileformat', 'fileencoding' } },
  },
  inactive = {
    left = { { 'relativepath', 'modified' } },
    right = { { 'line' }, { 'percent' } },
  },
  tabline = {
    left = { { 'tabs' } },
    right = {},
  }
}

-- Show line number
vim.o.number = true
-- replace tabulation with spaces
vim.o.expandtab = true
-- complete with longest common string from command mode on tab press
vim.o.wildmode = 'list:longest:lastused'
-- do not complete with some patterns
vim.o.wildignore = '*.o,*.obj,*.bak,*.exe,*~'
-- Numer of lines of history in command mode
vim.o.history = 100
-- enable backup
vim.o.backup = true

-- lilypond
local function setup_lilypond(lilypond_path)
  if vim.fn.isdirectory(lilypond_path) == 1 then
    vim.cmd('filetype off')
    vim.opt.runtimepath:append(lilypond_path)
    vim.cmd('filetype on')
    vim.cmd('syntax on')
  end
end
setup_lilypond('/usr/share/lilypond/2.22.1/vim')

if vim.fn.isdirectory('/usr/share/doc/fzf/examples') then
  vim.opt.runtimepath:append('/usr/share/doc/fzf/examples')
end

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
