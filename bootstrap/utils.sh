#!/usr/bin/env bash


ask_for_sudo() {
  sudo -v &> /dev/null
}


ask_for_confirmation() {
  print_in_yellow "   [?] ${1} (y/n) "
  read -r -n 1 -t 5
  printf "\n"
}


answer_is_yes() {
  [[ "$REPLY" =~ ^[Yy]$ ]] && return 0 || return 1
}


command_exists() {
  return $(hash $1 > /dev/null 2>&1)
}


print_in_red() {
  printf "\033[31m$1\033[m"
}


print_in_green() {
  printf "\033[32m$1\033[m"
}


print_in_yellow() {
  printf "\033[33m$1\033[m"
}


print_in_blue() {
  printf "\033[34m$1\033[m"
}


heading() {
  print_in_blue "\n • ${1}\n"
}


subheading() {
  print_in_blue "\n   ${1}\n\n"
}


spinstr='|/-\'
spinner() {
  local pid=$1
  local delay=0.1
  local size=$((${#2}+4))
  printf "   "
  while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
    local temp=${spinstr#?}
    print_in_yellow "[${spinstr:0:1}] ${2}"
    spinstr=$temp${spinstr%"$temp"}
    sleep $delay
    eval printf '\\b%.0s' {1..$size}
  done
}


execute() {
  eval $1 > /dev/null 2>&1 &
  spinner $! "${2}"
  wait %1
  if [ $? -eq 0 ]; then
    print_in_green "[✔] ${2}\n"
    return 0
  else
    print_in_red "[✖] ${2}\n"
    return 1
  fi
}
