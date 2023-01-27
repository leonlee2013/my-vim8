#!/bin/bash

sudo apt-get install -y cmake npm openjdk-17-jdk python3-dev
cd ~/.vim/bundle/
git clone https://github.com/ycm-core/YouCompleteMe
cd ./YouCompleteMe
git submodule update --init --recursive
./install.py --all
