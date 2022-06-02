filetype plugin indent on "Включает определение типа файла, загрузку...
"... соответствующих ему плагинов и файлов отступов
set encoding=utf-8 "Ставит кодировку UTF-8
set nocompatible "Отключает обратную совместимость с Vi
syntax enable "Включает подсветку синтаксиса
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Jan 26
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'lervag/vimtex'
"Plug 'rafi/awesome-vim-colorschemes'
Plug 'sirver/ultisnips'
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'} 
Plug 'lyokha/vim-xkbswitch'
Plug 'shime/vim-livedown'
"Plug 'connorholyday/vim-snazzy'
Plug 'preservim/nerdtree'
Plug 'dylanaraps/wal.vim'
Plug 'chrisbra/csv.vim'
Plug '907th/vim-auto-save'
"Plug 'ycm-core/YouCompleteMe'
"Plug 'ervandew/supertab'
"Plug '907th/vim-auto-save'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()
"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
"
"
"if (empty($TMUX))
"  if (has("nvim"))
" "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
"  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"  endif
"  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
"  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
"  if (has("termguicolors"))
"    set termguicolors
"  endif
"endif

"nmap <localleader>ll :silent <plug>(vimtex-compile)
"map <F5> :wall!<CR>:!sbcl --load foo.cl<CR><CR>


"Отключаем автоматическое открытие окна Quickfix
let g:vimtex_quickfix_mode = 0
let g:vimtex_view_method = 'zathura'
set conceallevel=1
let g:tex_conceal='abdmg' 

let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

setlocal spell
set spelllang=ru,en_gb
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
"set guioptions-=r "Отключаем панели прокрутки в GUI
set showtabline=0 "Отключаем панель табов (окошки FTW)
set number
"set wrap linebreak nolist
"set textwidth=78
"set colorcolumn=80
colorscheme wal
let g:XkbSwitchEnabled = 1 "Дёргаем рубильник:

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
"if has('gui_running')
"    " GUI colors
"    set background=light
"else
"    " Non-GUI (terminal) colors
"    set background=dark
"endif

inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>

inoremap <C-q> <C-O>:silent call vimtex#env#change_surrounding_to('env_math','multline*')<CR><CR>
nnoremap <C-q> :silent call vimtex#env#change_surrounding_to('env_math','multline*')<CR><CR><CR>

"function! Synctex()
"  execute "silent !zathura --synctex-forward " . line('.') . ":" . col('.') . ":" . bufname('%') . " " . g:syncpdf
"  redraw!
"endfunction
"if exists('+cmdheight') && (&ch < 3) 
"  set ch=3 
"endif "map <C-enter> :call Synctex()<cr>

let g:tex_flavor = "latex"

"let g:UltiSnipsListSnippets="<C-l>"

set rtp+=~/mipt/current-course

  call vimtex#imaps#add_map({
    \ 'lhs' : ';',
    \ 'rhs' : '\qquad',
    \ 'wrapper' : 'vimtex#imaps#wrap_math'
    \})
  call vimtex#imaps#add_map({
    \ 'lhs' : ':',
    \ 'rhs' : '\quad',
    \ 'wrapper' : 'vimtex#imaps#wrap_math'
    \})
"  call vimtex#imaps#add_map({
"			  \ 'lhs' : 't', 
"			  \'rhs' : 'vimtex#imaps#style_math("tilde")',
"			  \ 'expr' : 1,
"			  \ 'leader' : '#'})
"
"  call vimtex#imaps#add_map({
"			  \ 'lhs' : 'h', 
"			  \'rhs' : 'vimtex#imaps#style_math("hat")',
"			  \ 'expr' : 1,
"			  \ 'leader' : '#'})
"
"  call vimtex#imaps#add_map({
"			  \ 'lhs' : 'd', 
"			  \'rhs' : 'vimtex#imaps#style_math("dot")',
"			  \ 'expr' : 1,
"			  \ 'leader' : '#'})
"
"  call vimtex#imaps#add_map({
"			  \ 'lhs' : 'D', 
"			  \'rhs' : 'vimtex#imaps#style_math("ddot")',
"			  \ 'expr' : 1,
"			  \ 'leader' : '#'})

  " Add custom mapping through vimtex#imap#add_map
  call vimtex#imaps#add_map({
        \ 'lhs' : '.',
        \ 'rhs' : '\cdot ',
        \ 'wrapper' : 'vimtex#imaps#wrap_trivial'
        \})
  
  " Add custom mapping through vimtex#imap#add_map
  call vimtex#imaps#add_map({
        \ 'lhs' : '1',
        \ 'rhs' : '\mathbbold{1} ',
        \ 'wrapper' : 'vimtex#imaps#wrap_trivial'
        \})
 
  " Add custom mapping through vimtex#imap#add_map
  call vimtex#imaps#add_map({
        \ 'lhs' : 'H',
        \ 'rhs' : '\hbar ',
        \ 'wrapper' : 'vimtex#imaps#wrap_trivial'
        \})
   " Add custom mapping through vimtex#imap#add_map
  call vimtex#imaps#add_map({
        \ 'lhs' : '/',
        \ 'rhs' : '\wedge ',
        \ 'wrapper' : 'vimtex#imaps#wrap_trivial'
        \})
  " Add custom mapping through vimtex#imap#add_map
  call vimtex#imaps#add_map({
        \ 'lhs' : 'e',
        \ 'rhs' : '\epsilon ',
        \ 'wrapper' : 'vimtex#imaps#wrap_trivial'
        \})
  " Add custom mapping: #rX -> \mathrm{X}
  call vimtex#imaps#add_map({
        \ 'lhs' : 'r',
        \ 'rhs' : 'vimtex#imaps#style_math("mathrm")',
        \ 'expr' : 1,
        \ 'leader' : '#',
        \ 'wrapper' : 'vimtex#imaps#wrap_math'
        \})
  call vimtex#imaps#add_map({
        \ 'lhs' : 's',
        \ 'rhs' : 'vimtex#imaps#style_math("mathsf")',
        \ 'expr' : 1,
        \ 'leader' : '#',
        \ 'wrapper' : 'vimtex#imaps#wrap_math'
        \})


autocmd BufNewFile,BufRead *.tex EnableXkbSwitch
let g:XkbSwitchPostIEnterAuto = [[{'ft': 'tex', 'cmd': 'call Set_lang()'}, 0]]


augroup mathmode_toggler
  autocmd!
  autocmd CursorMovedI *.tex call Set_lang()
  autocmd CursorHoldI  *.tex call Set_lang()
  "autocmd InsertEnter  *.tex call Set_lang()
  autocmd TextChangedI *.tex call Set_lang()
augroup END

function! Set_lang()
  if exists('g:set_us')
    call libcall(g:XkbSwitchLib, 'Xkb_Switch_setXkbLayout', 'us(mac)')
    unlet g:set_us
  endif
  if exists('g:set_ru')
    call libcall(g:XkbSwitchLib, 'Xkb_Switch_setXkbLayout', 'ru(mac)')
    unlet g:set_ru
    return 0
  endif
  if !exists('s:was_in_env')
    let s:was_in_env = 0
    let s:cur_layout =
		\ libcall(g:XkbSwitchLib, 'Xkb_Switch_getXkbLayout', '')
  endif
  if s:was_in_env
    call libcall(g:XkbSwitchLib, 'Xkb_Switch_setXkbLayout', s:cur_layout)
  else
	  let s:cur_layout =
		\ libcall(g:XkbSwitchLib, 'Xkb_Switch_getXkbLayout', '')
  endif
  if vimtex#syntax#in_mathzone() || vimtex#syntax#in('texEnvArgName')
	  if vimtex#syntax#in('texMathText')
		  let s:was_in_env = 0
		  return 0
	  else
		  call libcall(g:XkbSwitchLib, 'Xkb_Switch_setXkbLayout', 'us(mac)')
		  let s:was_in_env = 1
		  return 1
	  endif
  else
    let s:was_in_env = 0
    return 0
  endif
endfunction


"let g:XkbSwitchSkipIMappings =
 "       \ {'*'   : ['.', '>', ':', ';', ',', '{<CR>', '/*', '/*<CR>'],}
        let g:XkbSwitchSkipIMappings =
        \ {'c'   : ['.', '>', ':', '{<CR>', '/*', '/*<CR>'],
        \  'cpp' : ['.', '>', ':', '{<CR>', '/*', '/*<CR>']}


let g:auto_save = 1  " enable AutoSave on Vim startup

set rtp+=~/current_course

set wrap linebreak

"let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
"let g:ycm_add_preview_to_completeopt="popup"
"let g:ycm_autoclose_preview_window_after_completion=0
"set completeopt-=preview
"let g:ycm_filetype_blacklist = {'tex' : 1}
"let g:ycm_filetype_whitelist = {'cpp' : 1}


" make YCM compatible with UltiSnips (using supertab)
"let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
"let g:SuperTabDefaultCompletionType = '<C-n>'
"
"" better key bindings for UltiSnipsExpandTrigger
"let g:UltiSnipsExpandTrigger = "<tab>"
"let g:UltiSnipsJumpForwardTrigger = "<tab>"
"let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
"
"let g:ycm_filetype_specific_completion_to_disable = {
"      \ 'tex': 1
"      \}
"

if empty(v:servername) && exists('*remote_startserver')
      call remote_startserver('VIM')
    endif

set mmp=5000

au FocusLost * :wa
