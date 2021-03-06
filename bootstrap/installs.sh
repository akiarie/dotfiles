#!/usr/bin/env bash

. utils.sh

check_os

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PARENTDIR="$(dirname "$DIR")"


symlink() {
  create_directory "$(dirname "${HOME}/${2}")"
  execute "ln -fs '${PARENTDIR}/${1}' '${HOME}/${2}'" "${1} → ~/${2}"
  sleep 0.25
}


install_homebrew() {
  if ! command_exists brew; then
    execute "echo | ruby -e '$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)'" "Homebrew (install)"
  fi
  execute "brew update" "Homebrew (update)"
}


if [ "${PLATFORM}" == "macOS" ]; then
  install_package() {
    execute "brew install ${2} || brew upgrade ${2}" "${1}"
  }
elif [ "${PLATFORM}" == "FreeBSD" ]; then
  install_package() {
    execute "sudo pkg install -y ${2} || sudo pkg upgrade -y ${2}" "${1}"
  }
else
  install_package() {
    execute "sudo apt -y install ${2}" "${1}"
  }
fi


install_pip2() {
  if command_exists pip2; then
    execute "pip2 install --upgrade pip" "PIP 2"
  else
    execute "curl -LsSo get-pip.py https://bootstrap.pypa.io/get-pip.py" "Download get-pip.py"
    execute "sudo python2 get-pip.py" "PIP 2"
    rm -f get-pip.py
  fi
}


install_pip3() {
  if command_exists pip3; then
    execute "pip3 install --upgrade pip" "PIP 3"
  else
    execute "curl -LsSo get-pip.py https://bootstrap.pypa.io/get-pip.py" "Download get-pip.py"
    execute "sudo python3 get-pip.py" "PIP 3"
    rm -f get-pip.py
  fi
}


if [ "${PLATFORM}" == "macOS" ]; then
  install_pip2_package() {
    execute "pip2 install ${2}" "${1}"
  }
else
  install_pip2_package() {
    execute "pip2 install --user ${2}" "${1}"
  }
fi


if [ "${PLATFORM}" == "macOS" ]; then
  install_pip3_package() {
    execute "pip3 install ${2}" "${1}"
  }
else
  install_pip3_package() {
    execute "pip3 install --user ${2}" "${1}"
  }
fi


clone_git_repository() {
  local name=$1
  local url=$2
  local folder=$3
  local install=1
  if [ -d "${folder}" ]; then
    ask_for_confirmation "${name} is already installed. Reinstall?"
    if answer_is_yes; then
      remove_directory "${folder}"
      install=0
    fi
  else
    install=0
  fi
  if [ $install -eq 0 ]; then
    execute "git clone --depth=1 ${url} ${folder}" "Clone ${name}"
  fi
}


check_package_installed() {
  local name=$1
  local command=$2

  if [ "${PLATFORM}" == "FreeBSD" ]; then
    pkg info "${command}" > /dev/null 2>&1
  else
    dpkg -s "${command}" > /dev/null 2>&1
  fi
  if [ $? -eq 0 ]; then
    ask_for_confirmation "${name} is already installed. Reinstall?"
    if answer_is_yes; then
      if [ "${PLATFORM}" == "FreeBSD" ]; then
        execute "sudo pkg delete -y ${command}" "Remove current ${name}"
      else
        execute "sudo apt -y remove ${command}" "Remove current ${name}"
      fi
      return 0
    fi
  else
    return 0
  fi
  return 1
}


install_deb_package() {
  local name=$1
  local url=$2
  local output=$(mktemp /tmp/XXXXX)
  execute "curl -LsSo ${output} ${url}" "Download ${name} archive"
  if [ $? -ne 0 ]; then
    return
  fi
  execute "sudo dpkg -i ${output}" "Install ${name}"
  if [ $? -ne 0 ]; then
    execute "sudo apt -y install -f" "Fixing dependencies for ${name}"
    execute "sudo dpkg -i ${output}" "Install ${name}"
  fi
}


clone_oh_my_zsh() {
  if [ ! -n "${ZSH}" ]; then
    ZSH=~/.oh-my-zsh
  fi
  clone_git_repository "Oh My Zsh" \
    "https://github.com/robbyrussell/oh-my-zsh.git" \
    "${ZSH}"
}

clone_base16_shell_theme() {
  clone_git_repository "Base16 Shell" \
    "https://github.com/chriskempson/base16-shell" \
    "${HOME}/.config/base16-shell"
}

install_vim_plugins() {
  create_directory "$(dirname "${HOME}/.vim/autoload")"
  clone_git_repository "autocorrect" \
      "https://github.com/panozzaj/vim-autocorrect.git" \
      "${HOME}/.vim/bundle/autocorrect.vim"
  clone_git_repository "base16" \
      "https://github.com/chriskempson/base16-vim.git" \
      "${HOME}/.vim/bundle/base16-vim"
  clone_git_repository "closetag" \
      "https://github.com/alvan/vim-closetag.git" \
      "${HOME}/.vim/bundle/closetag.vim"
  clone_git_repository "command-t" \
      "https://github.com/wincent/command-t.git" \
      "${HOME}/.vim/bundle/command-t"
  clone_git_repository "delimitMate" \
      "https://github.com/Raimondi/delimitMate.git" \
      "${HOME}/.vim/bundle/delimitMate"
  clone_git_repository "ghcmod-vim" \
      "https://github.com/eagletmt/ghcmod-vim.git" \
      "${HOME}/.vim/bundle/ghcmod-vim"
  clone_git_repository "julia-syntax.vim" \
      "https://github.com/ajpaulson/julia-syntax.vim.git" \
      "${HOME}/.vim/bundle/julia-syntax.vim"
  clone_git_repository "julia-vim" \
      "https://github.com/JuliaEditorSupport/julia-vim" \
      "${HOME}/.vim/bundle/julia-vim"
  clone_git_repository "loupe" \
      "https://github.com/wincent/loupe.git" \
      "${HOME}/.vim/bundle/loupe"
  clone_git_repository "NERDCommenter" \
      "https://github.com/scrooloose/nerdcommenter" \
      "${HOME}/.vim/bundle/nerdcommenter"
  clone_git_repository "NERDTree" \
    "https://github.com/scrooloose/nerdtree.git" \
    "${HOME}/.vim/bundle/nerdtree"
  clone_git_repository "rust" \
    "https://github.com/rust-lang/rust.vim.git" \
    "${HOME}/.vim/bundle/rust.vim"
  clone_git_repository "STL-Syntax" \
    "https://github.com/vim-scripts/STL-Syntax.git" \
    "${HOME}/.vim/bundle/STL-Syntax.vim"
  clone_git_repository "supertab" \
    "https://github.com/ervandew/supertab.git" \
    "${HOME}/.vim/bundle/supertab"
  clone_git_repository "Syntastic" \
    "https://github.com/vim-syntastic/syntastic.git" \
    "${HOME}/.vim/bundle/syntastic"
  clone_git_repository "Tagbar" \
    "https://github.com/majutsushi/tagbar.git" \
    "${HOME}/.vim/bundle/tagbar"
  clone_git_repository "vim-airline" \
    "https://github.com/vim-airline/vim-airline.git" \
    "${HOME}/.vim/bundle/vim-airline"
  clone_git_repository "vim-cfmt" \
    "https://github.com/crosbymichael/vim-cfmt.git" \
    "${HOME}/.vim/bundle/vim-cfmt"
  clone_git_repository "vim-flake8" \
    "https://github.com/nvie/vim-flake8.git" \
    "${HOME}/.vim/bundle/vim-flake8"
  clone_git_repository "vim-go" \
    "https://github.com/fatih/vim-go.git" \
    "${HOME}/.vim/bundle/vim-go"
  clone_git_repository "vim-localvimrc" \
    "https://github.com/embear/vim-localvimrc.git" \
    "${HOME}/.vim/bundle/vim-localvimrc"
  clone_git_repository "vimproc" \
    "https://github.com/Shougo/vimproc.vim.git" \
    "${HOME}/.vim/bundle/vimproc.vim"
  clone_git_repository "vim-sensible" \
    "https://github.com/tpope/vim-sensible.git" \
    "${HOME}/.vim/bundle/vim-sensible"
  clone_git_repository "vim-surround" \
    "https://github.com/tpope/vim-surround.git" \
    "${HOME}/.vim/bundle/vim-surround"
}


make_ssh_dir() {
  create_directory "$(dirname "${HOME}/.ssh")"
}
