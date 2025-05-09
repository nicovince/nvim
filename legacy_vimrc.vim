" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? 'evim'
  finish
endif


"-----------------------------------------------------------------------------
" Vim General Config
"-----------------------------------------------------------------------------

" runtimepath is used to get vim configuration files and folders
" default value is to $HOME/.vim which may not work when using
" vim -u /path/to/vimrc
" since i know this file is in my vim folder I can retrieve vim folder
" by getting full path of this file without the filename
let $nvimfolder = expand('<sfile>:p:h')

let $localvimrc = $nvimfolder . '/local.vim'
if filereadable($localvimrc)
  source $localvimrc
endif

" Source utils.vim when using neovim
if has('nvim')
  let $utilsvimrc =  $nvimfolder . '/plugin/utils.vim'
  source $utilsvimrc
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" clang-format mappings
map <C-K> :py3file /usr/share/vim/addons/syntax/clang-format.py<cr>
imap <C-K> <c-o>:py3file /usr/share/vim/addons/syntax/clang-format.py<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>


" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has('gui_running')
  syntax on
  set hlsearch
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Only do this part when compiled with support for autocommands.
if has('autocmd')

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  "autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif


  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Highlight trailing space, must be set before colorscheme command
  " Based on https://vim.fandom.com/wiki/Highlight_unwanted_spaces
  autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

  augroup END

else

  set autoindent    " always set autoindenting on

endif " has("autocmd")
