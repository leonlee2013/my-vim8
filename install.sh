#!/bin/bash
#git clone https://github.com/tpope/vim-pathogen.git

 set -e
 ABSFile=`realpath $0`
 ExecPath=`realpath "$(dirname $ABSFile)"`
 mkdir -p $ExecPath/.vim/bundle && cd $ExecPath/.vim/bundle
  for github in `cat $ExecPath/vim_plugins.ini` ; do
    git clone $github
  done
 cd $ExecPath

# 获取当前日期和时间，并格式化为YYYY-MM-DD_HH-MM-SS的形式
current_date=$(date +"%Y-%m-%d_%H-%M-%S")
# 使用日期来修改文件名
  #备份.vimrc
 if [ -f "~/.vimrc" ]; then
  mv "~/.vimrc" "~/.vimrc_${current_date}"
  echo "已备份为：~/.vimrc_${current_date}"
 else
  echo ".vimrc不存在"
 fi

 #备份.vim目录
 if [ -d "~/.vimrc" ]; then
  mv "~/.vim" "~/.vim_${current_date}"
  echo "已备份为：~/.vim_${current_date}"
 else
  echo ".vim目录不存在"
 fi
 cp -rf ./.vimrc ~/
 cp -rf ./.vim ~/
