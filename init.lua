-- Source legacy vimrc configuration
local vimrc = vim.fn.stdpath("config") .. "/legacy_vimrc.vim"
vim.cmd.source(vimrc)

------------------------
--- interface config ---
------------------------

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


---------------
--- keymaps ---
---------------
-- Highlight extra whitespace
vim.cmd('highlight ExtraWhitespace ctermbg=red guibg=red')
-- Global variable to control highlighting
vim.g.highlight_trailing_ws = 1
-- Function to match trailing whitespace
function MatchTrailingWS()
    if vim.g.highlight_trailing_ws == 1 then
        vim.cmd('match ExtraWhitespace /\\s\\+$/')
    end
end

-- Function to match trailing whitespace except for the current line
function MatchTrailingWSExceptCurrent()
    if vim.g.highlight_trailing_ws == 1 then
        vim.cmd('match ExtraWhitespace /\\s\\+\\%#\\@<!$/')
    end
end

-- Function to enable highlighting
function EnableHighlightTrailingWS()
    vim.g.highlight_trailing_ws = 1
    vim.cmd('highlight ExtraWhitespace ctermbg=red guibg=red')
    MatchTrailingWS()
end

-- Function to disable highlighting
function DisableHighlightTrailingWS()
    vim.g.highlight_trailing_ws = 0
    vim.cmd('highlight clear ExtraWhitespace')
end

-- Initial call to match trailing whitespace
MatchTrailingWS()

-- Key mappings to toggle highlighting on and off
vim.api.nvim_set_keymap('n', '<Leader>wn', ':lua EnableHighlightTrailingWS()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>wf', ':lua DisableHighlightTrailingWS()<CR>', { noremap = true, silent = true })

vim.api.nvim_create_autocmd("WinEnter", {
  pattern = { "*" },
  command = "lua MatchTrailingWS()"
})
vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = { "*" },
  command = "lua MatchTrailingWSExceptCurrent()"
})
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = { "*" },
  command = "lua MatchTrailingWS()"
})
vim.api.nvim_create_autocmd("BufWinLeave", {
  pattern = { "*" },
  command = "call clearmatches()"
})


-- command mode mapping
-- Saner command line history
-- Uses ctrl-p and ctrl-n to go up in history by recalling command line whose
-- beginning matches the current command line (similar to bash
-- history-search-backward/forward)
vim.api.nvim_set_keymap('c', '<C-n>', '<Down>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('c', '<C-p>', '<Up>', { noremap = true, silent = false })

-- Abbreviation in command mode to replace '%%' with the path of the current file
vim.api.nvim_set_keymap('c', '%%', "expand('%:h')", { expr = true, noremap = true })

-- fix typos in command line mode
vim.cmd([[cabbrev hlep help]])
vim.cmd([[cabbrev hepl help]])


-- ctags mapping
-- jump to tag under cursor
vim.keymap.set('n', '!z', ':Tags <C-R><C-W><CR>', { noremap = true, silent = true })
-- tab window
vim.keymap.set('n', '!t', ':tab split <CR> :Tags <C-R><C-W><CR>', { noremap = true, silent = true })
-- split window
vim.keymap.set('n', '!s', ':split <CR> :Tags <C-R><C-W><CR>', { noremap = true, silent = true })


-- filetypes per file extension or pattern or filename
vim.filetype.add({
  extension = {
    lypp = 'lilypond',
    overlay = 'dts',
    vh = 'verilog',
  },
})

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
