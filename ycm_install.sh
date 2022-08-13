#!/bin/bash

sudo dnf install -y cmake python3-devel npm
cd ~/.vim/bundle/
git clone https://github.com/ycm-core/YouCompleteMe
cd ./YouCompleteMe
git submodule update --init --recursive
./install.py --all
