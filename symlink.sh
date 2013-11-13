#!/bin/bash

# create symlinks from the home directory to dotfiles in ~/dotfiles

dir=~/dotfiles
dotfiles="profile inputrc vim vimrc gvimrc gitconfig gitignore_global"
rawfiles="bin"

# symlink dotfiles to the the home dir, each prefixed by a dot (.)
cd $dir
for file in $dotfiles; do
    ln -s $dir/$file ~/.$file
done

# symlink regular files to the the home dir
for file in $rawfiles; do
    ln -s $dir/$file ~/$file
done
