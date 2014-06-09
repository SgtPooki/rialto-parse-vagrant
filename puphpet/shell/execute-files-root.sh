#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

VAGRANT_CORE_FOLDER=$(cat '/.puphpet-stuff/vagrant-core-folder.txt')

shopt -s nullglob
files=("${VAGRANT_CORE_FOLDER}"/files/exec-once/*)

if [[ ! -f '/.puphpet-stuff/exec-once-ran-root' && (${#files[@]} -gt 0) ]]; then
    echo 'Running files in files/exec-once-root'
    find "${VAGRANT_CORE_FOLDER}/files/exec-once-root" -maxdepth 1 -not -path '*/\.*' -type f \( ! -iname "empty" \) -exec chmod +x '{}' \; -exec {} \;
    echo 'Finished running files in files/exec-once-root'
    echo 'To run again, delete file /.puphpet-stuff/exec-once-root-ran'
    touch /.puphpet-stuff/exec-once-root-ran
fi