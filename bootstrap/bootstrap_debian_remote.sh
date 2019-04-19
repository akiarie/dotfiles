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
change_shell    "zsh"

install_pip2

subheading "Deb packages"

subheading "Oh My Zsh"
clone_oh_my_zsh

subheading "Base16 Shell Theme"
clone_base16_shell_theme

subheading "Making ssh dir"
make_ssh_dir

subheading "Vim plugins"
install_vim_plugins

heading "Create symbolic links"

subheading "Configurations"
symlink "git/gitconfig"               ".gitconfig"
symlink "git/gitconfig_global"        ".gitconfig_global"
symlink "ssh/authorized_keys"         ".ssh/authorized_keys"
symlink "vim/ftplugin"                ".vim/after/ftplugin"
symlink "vim/pathogen.vim"            ".vim/autoload/pathogen.vim"
symlink "tmux/tmux_remote.conf"       ".tmux.conf"
symlink "vim/vimrc"                   ".vimrc"
symlink "zsh/zshrc_debian"             ".zshrc"
symlink "zsh/dircolors"               ".dircolors"
#symlink "zsh/aliases"                 ".aliases"
#symlink "zsh/aliases_ubuntu"          ".aliases_os"

subheading "Scripts"
#symlink "bin/capslock.py"             ".local/bin/capslock"
#symlink "bin/femtocom.sh"             ".local/bin/femtocom"
#symlink "zsh/completions/passthesalt" ".oh-my-zsh/completions/_passthesalt"
#symlink "bin/ttyresize"               ".local/bin/ttyresize"


heading "General\n"
