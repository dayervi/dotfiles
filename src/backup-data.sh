#!/bin/bash

source $(dirname $0)/_common.sh

# save atom installed packages list
action_echo "saving list of atom installed packages"
apm list --installed --bare > $(pwd)/data/atom-needed-packages.txt