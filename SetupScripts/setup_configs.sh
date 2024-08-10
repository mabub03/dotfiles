#!/bin/bash
# copy things from dotfiles .config to $HOME/.config
# maybe replace with symlink idk
cp $HOME/dotfiles/BackedUpFiles/.config/starship.toml $HOME/.config/
cp -r $HOME/dotfiles/BackedUpFiles/.config/fontconfig $HOME/.config/
cp $HOME/dotfiles/BackedUpFiles/.config/gtk-3.0/* $HOME/.config/gtk-3.0/
cp $HOME/dotfiles/BackedUpFiles/.zshrc $HOME/.zshrc
