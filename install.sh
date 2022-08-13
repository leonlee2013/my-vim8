#!/bin/bash
 #git clone https://github.com/tpope/vim-pathogen.git

 #set -e
 ABSFile=`realpath $0`
 ExecPath=`realpath "$(dirname $ABSFile)"`
 mkdir -p $ExecPath/.vim/bundle && cd $ExecPath/.vim/bundle
  for github in `cat $ExecPath/vim_plugins.ini` ; do
    git clone $github
  done
 rm -rf ~/.vimrc;cp -rf ./.vimrc ~
 rm -rf ~/.vim; cp -rf ./.vim ~/
