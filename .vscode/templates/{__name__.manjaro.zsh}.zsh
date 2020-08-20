#!/bin/env bash
# -*- coding: utf-8 -*-
#
## @Author: {__author__}
## @Email: {__email__}
## @Copyright © {__author__}. All rights reserved. Contacts: {__email__}
## @Copyright © sensor-dream. All rights reserved. Contacts: {__email__}
## @Copyright © Sensor-Dream Boxed System (SDBS). Contacts: {__email__}
## @License: http://www.apache.org/licenses/LICENSE-2.0
## @Site: {__link__}
## @File: {__name__}.bash
## @Creation date file: {__date__}

#
#   Декларируем имя файла
#

declare -rx {__name__}_script_source="$0";

if [[ -z "${main_run_script_path}" ]]; then
  declare -rx main_run_script_path="$(pwd)";
  echo "Script runs from ${main_run_script_path}";
fi

#
#   Подключаем общую библиотеку и общую конфигурацию
#

if [[ -z "${main_cfg_script_source}" ]]; then
  check=1;
  while [[ ${check} -eq 1 ]]; do
    if [[ ! -f 'main.cfg' ]]; then
      if [[ "$(pwd)" != "/" ]]; then
        cd ../;
      else
        cd ${main_run_script_path};
        check=0;
        echo -e '\e[31m'"!!! Not found configuration shared file !!!\033[0m";
        tput sgr0;
        exit 1;
      fi
    else
      check=0;
      declare -rx main_project_path="$(pwd)";
      . "${main_project_path}/main.cfg";
      cd "${main_run_script_path}";
    fi
  done
fi

echo "Connect $(readlink -m ${{__name__}_script_source})";

function install_{__name__}(){

  local install_pkg=(\

);

  [[ -f /var/lib/pacman/db.lck ]] && sudo rm -r /var/lib/pacman/db.lck

  pkgs -i -- "${install_pkg[@]}"

}

function main_{__name__}_script_source(){

  echo "Initialise main function of {__name__} script source";

}

main_{__name__}_script_source "$@";
