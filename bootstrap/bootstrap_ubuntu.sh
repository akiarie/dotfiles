#!/usr/bin/env bash

. installs.sh

heading "Installs"

subheading "System packages"
execute "sudo apt update" "APT (update)"
install_package "Git"        "git"
install_package "Python 2"   "python"
install_package "tmux"       "tmux"
install_package "Vim"        "vim"
install_package "xclip"      "xclip"
install_package "Zsh"        "zsh"

install_pip2

subheading "Deb packages"

subheading "Oh My Zsh"
clone_oh_my_zsh

subheading "Base16 Shell Theme"
clone_base16_shell_theme

#subheading "Vim plugins"

heading "Create symbolic links"

subheading "Configurations"
#symlink "git/gitconfig"               ".gitconfig"
#symlink "git/gitconfig_global"        ".gitconfig_global"
symlink "tmux/tmux_remote.conf"              ".tmux.conf"
#symlink "vim/vimrc"                   ".vimrc"
symlink "zsh/zshrc"                   ".zshrc"
#symlink "zsh/aliases"                 ".aliases"
#symlink "zsh/aliases_ubuntu"          ".aliases_os"
#symlink "zsh/rossmacarthur.zsh-theme" ".oh-my-zsh/themes/rossmacarthur.zsh-theme"

subheading "Scripts"
#symlink "bin/capslock.py"             ".local/bin/capslock"
#symlink "bin/femtocom.sh"             ".local/bin/femtocom"
#symlink "zsh/completions/passthesalt" ".oh-my-zsh/completions/_passthesalt"
#symlink "bin/ttyresize"               ".local/bin/ttyresize"


heading "General\n"

disable_guest_login
