#!/bin/bash
# copy things from dotfiles .config to $HOME/.config
# maybe replace with symlink idk
cp $HOME/dotfiles/BackedUpFiles.config/starship.toml $HOME/dotfiles/.config
cp -r $HOME/dotfiles/BackedUpFiles/.config/fontconfig $HOME/dotfiles/.config
cp $HOME/dotfiles/BackedUpFiles/.config/gtk-3.0/* $HOME/dotfiles/.config/gtk-3.0
cp $HOME/dotfiles/BackedUpFiles/.config/starship.toml $HOME/dotfiles/.config
cp $HOME/dotfiles/BackedUpFiles/.zshrc $HOME/.zshrc
