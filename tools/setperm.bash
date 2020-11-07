#!/bin/env bash

export setperm_user="$(id -un)"
export setperm_group="apache"

[[ -f "README.md" ]] || cd ../

multiple_cmd() {
  if [[ "$0" != "./.git"* && "$0" != "./tools" && ! -L "$0" ]]; then
    echo "Find: $0"
    if [[ -f "$0" ]]; then
      sudo chmod 0664 "$0"
    else
      sudo chmod 0775 "$0"
    fi
    sudo chown ${setperm_user}.${setperm_group} "$0"
  fi
}

export -f multiple_cmd

find . -exec bash -c 'multiple_cmd "$0"' {} \;

# find . -type d -exec bash -c 'multiple_cmd "$0"' {} \;
