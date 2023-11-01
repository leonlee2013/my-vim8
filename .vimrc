set nocompatible
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" if has("vms")
"   set nobackup		" do not keep a backup file, use versions instead
" else
"   set nobackup		" keep a backup file
" endif
set history=500		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" In many terminal emulators the mouse works just fine, thus enable it.
" if has('mouse')
"   set mouse=a
" endif

" set autoindent		" always set autoindenting on
set ts=2
set sw=2
set expandtab
set smartindent
set cindent
set laststatus=2   " always show status line
highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue
set statusline=[%n]\|pwd:%{CurDir()}\ File:%f%m%r%h\ \|%=\|\ %l,%c\ %p%%\ \|%{((&fenc==\"\")?\"\":\"\ \|\ \".&fenc)}\ 
augroup vimrcEx
  au!
  autocmd FileType text setlocal textwidth=78
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup END
set number
set hlsearch
syntax on                    "开启文件类型侦测
syn on
"==============================================================================
" taglist
"==============================================================================
nnoremap <silent> <F9> :TlistToggle<CR>
let Tlist_Auto_Open = 0
let Tlist_Use_Right_Window = 1
let Tlist_Use_SingleClick = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_WinWidth = 80

"==============================================================================
" 获取当前路径，将$HOME转化为~
"==============================================================================
function! CurDir()	
	let curdir = substitute(getcwd(), $HOME, "~", "g")
	return curdir
endfunction

"==============================================================================
"管理插件配置
"==============================================================================
execute pathogen#infect()
filetype indent on           "针对不同的文件采用不同的缩进格式
filetype plugin  on          "这对不同的文件类型加载对应的插件
filetype plugin indent on    "启用自动补全功能

"==============================================================================
"gf路径配置
"==============================================================================
set path+=**/src/**/
" set path+=./*/src/**/
set path+=/usr/local/lib/erlang/lib/**/
" set path+=**/
set wildmenu 
"==============================================================================
"ctrlp的配置
"==============================================================================
let g:ctrlp_user_command = 'find %s -type f  -name "*.h" -o -name "*.c" -o -name "*.go" -o -name "*.erl" -o -name "*.hrl" -o -name "*.ex" -o -name "*.exs" -o -name "*.log" -o -name "*.thrift" -o -name "*.proto" -o -name "*.sh" ' "mac和linux 有效
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:30,results:45'
"==============================================================================
"定义快捷键
"==============================================================================
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
inoremap <leader>fe <esc>:grep -r --include='*.erl' --include='*hrl' --include='*ex' --include='*exs' --include='*proto' '\<<c-r><c-w>\>' .<cr><cr>:cw<cr><cr>
nnoremap <leader>fe :grep -r --include='*.erl' --include='*hrl' --include='*ex' --include='*exs' --include='*proto' '\<<c-r><c-w>\>' .<cr><cr>:cw<cr><cr>
xnoremap <leader>fe y:grep -r --include='*.erl' --include='*hrl' --include='*ex' --include='*exs' --include='*proto'  '<c-r>0' .<cr><cr>:cw<cr><cr>

"仅在go和proto文件中查找选中的单词
inoremap <leader>fg <esc>:grep -r --include='*.go' --include='*mod' --include='*proto' '\<<c-r><c-w>\>' .<cr><cr>:cw<cr><cr>
nnoremap <leader>fg :grep -r --include='*.go' --include='*mod' --include='*proto' '\<<c-r><c-w>\>' .<cr><cr>:cw<cr><cr>
xnoremap <leader>fg y:grep -r --include='*.go' --include='*mod' --include='*proto'  '<c-r>0' .<cr><cr>:cw<cr><cr>
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
" 映射按键 `<leader>fs` 以搜索选中的字符
vnoremap <leader>fs y:grep -r --include='*ex' --include='*.erl' --include='*hrl'  --include='*proto' '\<<c-r>"\>' .<cr><cr>:cw<cr><cr>
" 映射按键 `<leader>fv` 以搜索选中的字符
vnoremap <leader>fv y/<C-R>"<CR>
nnoremap <leader>fv y/<C-R>"<CR>
" 映射按键 `<leader>fsm` 以搜索选中的字符
vnoremap <leader>fm y:grep -r --include='*ex' --include='*.erl' --include='*hrl'  --include='*proto' 'defmodule \<<c-r>"\>'   .<cr><cr>:cw<cr><cr>


" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
"==============================================================================
""  Valloric/YouCompleteMe 插件
"==============================================================================
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<C-p>"
"let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
"let g:UltiSnipsListSnippets="<c-l>"

"==============================================================================
"" 颜色和主题
"==============================================================================
set t_Co=256
highlight Search ctermbg=yellow ctermfg=black 
hi DiffAdd    ctermbg=235  ctermfg=108  guibg=#262626 guifg=#87af87 cterm=reverse gui=reverse " 新增的行
hi DiffChange ctermbg=235  ctermfg=103  guibg=#262626 guifg=#8787af cterm=reverse gui=reverse " 变化的行
hi DiffDelete ctermbg=235  ctermfg=131  guibg=#262626 guifg=#af5f5f cterm=reverse gui=reverse " 删除的行
hi DiffText   ctermbg=235  ctermfg=208  guibg=#262626 guifg=#ff8700 cterm=reverse gui=reverse " 变化的文字
" colorscheme molokai
" colorscheme lucius
" colorscheme gruvbox
colorscheme jellybeans
" let g:vim_markdown_folding_disabled = 1
" let env_value = $TMUX
" if !empty(env_value)
  " colorscheme industry
  " colorscheme elflord
" endif

" set paste
" 防止文本格式错乱 " 因为 'paste' 激活时不能用映射
" 'pastetoggle' 选项可以用来指定切换 'paste' 选项的热键。
set pastetoggle=<F10>
" map <F7>:set paste<CR>
" map <F8>:set nopaste<CR>
" 关掉vim发出的提示音；
set vb t_vb=

"==============================================================================
"" vim-go 插件
" https://github.com/fatih/vim-go-tutorial#quick-setup
"==============================================================================
set autowrite
let g:go_fmt_command = "goimports" " 格式化将默认的 gofmt 替换
let g:go_list_type = "quickfix"
let g:go_autodetect_gopath = 1
let g:go_auto_type_info = 1
let g:go_highlight_functions = 1 " 突出显示函数和方法调用
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1 " 突出显示以下运算符
let g:go_version_warning = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_extra_types = 1 " 突出显示额外类型
let g:go_highlight_methods = 1
let g:go_highlight_generate_tags = 1
let g:go_auto_sameids = 1 " 自动高亮匹配的标识符
"关闭自动匹配
inoremap <leader>ns <esc>:let g:go_auto_sameids = 0:<cr> 
nnoremap <leader>ns :let g:go_auto_sameids = 0<cr>
xnoremap <leader>ns :let g:go_auto_sameids = 0<cr>
"打开自动匹配
inoremap <leader>s <esc>:let g:go_auto_sameids = 1:<cr> 
nnoremap <leader>s :let g:go_auto_sameids = 1<cr>
xnoremap <leader>s :let g:go_auto_sameids = 1<cr>

" let g:godef_split=2
" let g:go_addtags_transform = "camelcase" " 默认情况下，vim-go 使用snake_case
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
autocmd FileType go nmap <Leader>i <Plug>(go-info)
" Rename the identifier under the cursor to a new name
autocmd FileType go nmap <Leader>re <Plug>(go-rename)
" :GoCallers 找到当前函数被调用的地点
autocmd FileType go nmap <Leader>dc <Plug>(go-callers)
" :GoImplements 跳转到该函数实现的接口定义处 (struct 方法定义 -> interface 定义)
autocmd FileType go nmap <Leader>di <Plug>(go-implements)
" GoCallees 从函数调用处跳转到接口的真正实现，而不是接口定义 (方法调用点 -> struct 方法实现)
autocmd FileType go nmap <Leader>dd <Plug>(go-callees) 

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)


nmap <Leader>la :ErlangTags<CR>
nmap <Leader>le :ErlangEnableShowErrors <CR>
nmap <Leader>ld :ErlangDisableShowErrors <CR>
let erlang_show_errors = 0

" ErlangDisableShowErrors  ErlangEnableShowErrors    ErlangToggleShowErrors
"==============================================================================
" YouCompleteMe 插件
" YCM可以打开location-list来显示警告和错误的信息:YcmDiags
"==============================================================================
"跳转到定义GoToDefinition
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
"跳转到声明GoToDeclaration
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
"以及两者的合体GoToDefinitionElseDeclaration
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

nnoremap <leader>gc :YcmCompleter GoToCallers <CR>
nnoremap <leader>gi :YcmCompleter GoToImplementation <CR>
nnoremap <leader>gd :YcmCompleter GoToCallees <CR>

"跳转到定义LspDefinition
nnoremap <leader>] :LspDefinition<CR>
nnoremap <leader>cd :LspDefinition<CR>
" :LspDocumentSymbol  显示文档符号
nnoremap <leader>co :LspDocumentSymbol<CR>
" :LspHover 显示悬停信息
nnoremap <leader>ch :LspHover<CR>
" :LspPeekDefinition  转到光标下单词的定义，但在预览窗口中打开
nnoremap <leader>cp :LspPeekDefinition<CR>

" 补全对话框的颜色修改
" https://www.ditig.com/256-colors-cheat-sheet
highlight PMenu ctermfg=0 ctermbg=242 guifg=black guibg=darkgrey
highlight PMenuSel ctermfg=242 ctermbg=8 guifg=darkgrey guibg=black

" YCM 关闭自动弹出函数原型预览窗
" set completeopt=menu,menuone
" let g:ycm_add_preview_to_completeopt = 0
"==============================================================================
"导航目录的侧边栏
"==============================================================================
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" 开关 弹出窗口中显示文档
nmap <leader>d <plug>(YCMHover)
" 关闭 弹出窗口中显示文档功能
let g:ycm_auto_hover=''
" 插入(x)日期
" iab xtime <c-r>=strftime("%Y-%m-%d %H:%M:%S")<cr>
inoremap <leader>xt <c-r>=strftime("%Y-%m-%d %H:%M:%S")<cr>

" inoremap <leader>" <Esc>:s/<c-r><c-w>/"<c-r><c-w>"/<cr>
" nnoremap <leader>" :s/<c-r><c-w>/"<c-r><c-w>"/<cr>
" xnoremap <leader>" y:s/<c-r>0/"<c-r>0"/<cr>

" Let clangd fully control code completion
" let g:ycm_clangd_uses_ycmd_caching = 0
" " Use installed clangd, not YCM-bundled clangd which doesn't get updates.
" let g:ycm_clangd_binary_path = exepath("clangd")

au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
au BufRead,BufNewFile *.eex,*.heex,*.leex,*.sface,*.lexs set filetype=eelixir
au BufRead,BufNewFile mix.lock set filetype=elixir

" 显示消息的延迟（以毫秒为单位）。设置得太低可能会导致性能问题。 " 默认：1000
let g:blamer_delay = 500
" 以相对格式显示提交日期  默认：0
let g:blamer_relative_time = 1
" 消息的颜色,默认：link Blamer Comment
" highlight Blamer guifg=lightgrey
let g:blamer_enabled = 1


