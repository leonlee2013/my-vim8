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
sudo dnf install -y cmake python3-devel npm
cd ~/.vim/bundle/
git clone https://github.com/ycm-core/YouCompleteMe
cd ./YouCompleteMe
git submodule update --init --recursive
./install.py --all
```
