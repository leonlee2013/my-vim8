# my-vim8
**几个不错的颜色主题**

https://github.com/tomasr/molokai

https://github.com/morhetz/gruvbox

https://github.com/nanotech/jellybeans.vim

https://github.com/jonathanfilip/vim-lucius


**alma9.0-安装YouCompleteMe**

https://github.com/ycm-core/YouCompleteMe#linux-64-bit

先安装下go的最新版本
https://go.dev/doc/install
```bash
$ sudo dnf install -y cmake python3-devel npm
$ cd ~/.vim/bundle/
$ git clone https://github.com/ycm-core/YouCompleteMe
$ cd ./YouCompleteMe
$ git submodule update --init --recursive
$ ./install.py --all
Generating ycmd build configuration...OK
Compiling ycmd target: ycm_core...OK
Building regex module...OK
Building watchdog module...OK
Installing Omnisharp for C# support...OK
Building gopls for go completion...OK
Setting up Tern for JavaScript completion...OK
Installing rust-analyzer for Rust support...OK
Installing jdt.ls for Java support...OK
Setting up TSserver for TypeScript completion...OK
Setting up Clangd completer...OK
```
