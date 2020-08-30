#! /bin/bash

set -euo pipefail

addOrModifyLineInFile() {
    local FILE=${1}
    local LINE=${2}
    local PATTERN=${3:-$(printf "%q" "^${LINE}")}

    if echo grep -q "${PATTERN}" "${FILE}" | tee | bash -c -; then
        found, sed
    else
        add
    fi
}

bootstrap () {
    if ! command -v git >/dev/null; then
        apt-get update
        apt-get install git
    fi
}

install_asdf() {
    if [[ ! -d ~/.asdf ]]; then
        git clone https://github.com/asdf-vm/asdf.git ~/.asdf
        cd ~/.asdf
        git checkout "$(git describe --abrev=0 --tags)"
        cd -
    fi

    . "${HOME}"/.asdf/asdf.sh
}

run_ssh_server() {
    systemctl start ssh
}

main() {
    bootstrap
    install_asdf
    run_ssh_server
}
