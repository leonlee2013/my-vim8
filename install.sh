#!/bin/bash
 #git clone https://github.com/tpope/vim-pathogen.git
 cd ./.vim/bundle
 for github in `cat ./vim_plugins.ini` ; do
   git clone $github
 done

