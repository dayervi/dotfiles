#!/bin/bash

function color_echo() {
  tput setaf $2
  echo "$1"
  tput sgr0
}

function action_echo() {
  tput setaf 4
  echo -n "$1 "
  for i in $(seq 1 3); do
    sleep 0.5
    echo -n "."
  done
  echo ""
  tput sgr0
}

function ask() {
  read -p "$1 " answer
  echo $answer
}

function ask_permission() {
  tput setaf 3
  read -n 1 -p "warning: $1, continue (y/n)? " answer
  echo ""
  tput sgr0
  
  case ${answer} in
    y|Y ) return 1 ;;
    * ) return 0 ;;
  esac
}
