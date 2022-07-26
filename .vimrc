" ======================================================================================
" vim 内置配置 
" ======================================================================================

" 设置 vimrc 修改保存后立刻生效，不用在重新打开
" 建议配置完成后将这个关闭
autocmd BufWritePost $MYVIMRC source $MYVIMRC
set nocompatible
" allow backspacing over everything in insert mode
set backspace=indent,eol,start


if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set nobackup		" keep a backup file
endif
set history=500		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif


" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " filetype plugin indent on
  set ts=2
  set sw=2
	set expandtab
  set smartindent
  set cindent
  syn on
  set number

  " status line
  set laststatus=2   " always show status line
  "set statusline+=%f " show filename in status line
  highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue
  set statusline=[%n]\|pwd:%{CurDir()}\ File:%f%m%r%h\ \|%=\|\ %l,%c\ %p%%\ \|%{((&fenc==\"\")?\"\":\"\ \|\ \".&fenc)}\ 

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" taglist
nnoremap <silent> <F9> :TlistToggle<CR>
let Tlist_Auto_Open = 0
let Tlist_Use_Right_Window = 1
let Tlist_Use_SingleClick = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_WinWidth = 80

" 获取当前路径，将$HOME转化为~
function! CurDir()	
	let curdir = substitute(getcwd(), $HOME, "~", "g")
	return curdir
endfunction

"colorscheme molokai
"管理插件配置
execute pathogen#infect()
" syntax enable

" set cursorline               "突出显示当前行
" set showmatch                "显示括号匹配
syntax on                    "开启文件类型侦测
filetype indent on           "针对不同的文件采用不同的缩进格式
filetype plugin  on          "这对不同的文件类型加载对应的插件
filetype plugin indent on    "启用自动补全功能

"set path+=common/**/
set path+=/usr/local/lib/erlang/lib/**/
set path+=**/
set wildmenu 

"ctrlp的配置
let g:ctrlp_user_command = 'find %s -type f  -name "*.go" -o -name "*.erl" -o -name "*.hrl" -o -name "*.log" -o -name "*.proto" -o -name "*.sh" ' "mac和linux 有效
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:30,results:45'

"定义快捷键
let mapleader = ","
"全选
inoremap <leader>a <esc>ggvG 
nnoremap <leader>a ggvG
"隐藏行号
inoremap <leader>no <esc>:set nonumber:<cr> 
nnoremap <leader>no :set nonumber<cr>
xnoremap <leader>no :set nonumber<cr>
"显示行号
inoremap <leader>n <esc>:set number:<cr> 
nnoremap <leader>n :set number<cr>
xnoremap <leader>n :set number<cr>
"隐藏选中高亮
inoremap <leader>h <esc>:nohl<cr> 
nnoremap <leader>h :nohl<cr>
xnoremap <leader>h :nohl<cr>
"p4 打开当前文件
nnoremap <leader>o :!p4 open % <cr>:w!<cr>
"全局查找选中的单词
inoremap <leader>f <esc>:grep -r '\<<c-r><c-w>\>' .<cr><cr>:cw<cr><cr>
nnoremap <leader>f :grep -r '\<<c-r><c-w>\>' .<cr><cr>:cw<cr><cr>
xnoremap <leader>f y:grep -r '<c-r>0' .<cr><cr>:cw<cr><cr>
"仅在erlang和proto文件中查找选中的单词
inoremap <leader>fe <esc>:grep -r --include=*.erl --include=*hrl --include=*proto '\<<c-r><c-w>\>' .<cr><cr>:cw<cr><cr>
nnoremap <leader>fe :grep -r --include=*.erl --include=*hrl --include=*proto '\<<c-r><c-w>\>' .<cr><cr>:cw<cr><cr>
xnoremap <leader>fe y:grep -r --include=*.erl --include=*hrl --include=*proto  '<c-r>0' .<cr><cr>:cw<cr><cr>
"单词替换
inoremap <leader>w <Esc>:%s/<c-r>=expand("<cword>")<cr>/<c-r>=expand("<cword>")<cr>/g<Left><Left>
nnoremap <leader>w :%s/<c-r>=expand("<cword>")<cr>>/<c-r>=expand("<cword>")<cr>/g<Left><Left>
"单词替换,需要确认
inoremap <leader>wc <Esc>:%s/\<<c-r>=expand("<cword>")<cr>\>/<c-r>=expand("<cword>")<cr>/gc<Left><Left><Left>
nnoremap <leader>wc :%s/\<<c-r>=expand("<cword>")<cr>\>/<c-r>=expand("<cword>")<cr>/gc<Left><Left><Left>
"最近访问
inoremap <leader>e <Esc>:CtrlPMRUFiles<cr>
nnoremap <leader>e :CtrlPMRUFiles<cr>
inoremap <leader>r <Esc>:CtrlPBufTag<cr>
nnoremap <leader>r :CtrlPBufTag<cr>
inoremap <leader>t <Esc>:CtrlPBuffer<cr>
nnoremap <leader>t :CtrlPBuffer<cr>
"给选中的单词加引号
inoremap <leader>" <Esc>:s/<c-r><c-w>/"<c-r><c-w>"/<cr>
nnoremap <leader>" :s/<c-r><c-w>/"<c-r><c-w>"/<cr>
xnoremap <leader>" y:s/<c-r>0/"<c-r>0"/<cr>

"Trigger configuration. You need to change this to something other than <tab>
"if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" https://github.com/fatih/vim-go-tutorial#quick-setup
set autowrite
" 快速修复列表中的错误之间跳转
" map <C-n> :cnext<CR>
" map <C-m> :cprevious<CR>
" nnoremap <leader>a :cclose<CR>


autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
autocmd FileType go nmap <Leader>i <Plug>(go-info)
" let g:go_auto_type_info = 1
" let g:go_fmt_command = "goimports"
" 默认情况下，vim-go 使用snake_case
" let g:go_addtags_transform = "camelcase"
" let g:go_highlight_types = 1
" 突出显示函数和方法调用
let g:go_highlight_function_calls = 1
" 突出显示以下运算符
 " let g:go_highlight_operators = 1
" 突出显示额外类型
" let g:go_highlight_extra_types = 1
" 自动高亮匹配的标识符
" let g:go_auto_sameids = 1

let g:ycm_key_list_select_completion = ['<C-n>', '<space>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<C-p>"
"let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
"let g:UltiSnipsListSnippets="<c-l>"

" 用来提供一个导航目录的侧边栏
call pathogen#infect()
syntax on
filetype plugin indent on
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

highlight Search ctermbg=yellow ctermfg=black 
" 新增的行
hi DiffAdd    ctermbg=235  ctermfg=108  guibg=#262626 guifg=#87af87 cterm=reverse gui=reverse
" " 变化的行
hi DiffChange ctermbg=235  ctermfg=103  guibg=#262626 guifg=#8787af cterm=reverse gui=reverse
" " 删除的行
hi DiffDelete ctermbg=235  ctermfg=131  guibg=#262626 guifg=#af5f5f cterm=reverse gui=reverse
" " 变化的文字
hi DiffText   ctermbg=235  ctermfg=208  guibg=#262626 guifg=#ff8700 cterm=reverse gui=reverse
