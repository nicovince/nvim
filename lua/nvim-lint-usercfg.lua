-- configuration of nvim-lint plugin
require('lint').linters_by_ft = {
  ghaction = { 'actionlint' },
  python = { 'flake8' },
}

-- Run linter
-- LInter Run
vim.keymap.set('n', '<Leader>lir', function() require('lint').try_lint() end)

-- to hide the diagnostic after linting: ':ToggleDiagnostic'
