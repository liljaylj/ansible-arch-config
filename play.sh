#!/usr/bin/env bash

set -Eeuo pipefail

: "${1:?provide argument to script - path to the file with vault password or \`ask\`}"

read -rn1 -p 'Run system, flatpak and lvfs (firmware) update? [Y/n] ' yn

if [[ -n "$yn" ]]; then
    echo
fi

case "$yn" in
[Yy] | '')
    echo 'UPDATE PACKAGES...'
    sudo -u archconfig paru -Syu
    echo
    echo 'UPDATE FLATPAK...'
    sudo flatpak update
    echo
    echo 'UPDATE LVFS...'
    sudo fwupdmgr refresh || true
    sudo fwupdmgr update
    ;;
[Nn])
    echo 'Skipping system and flatpak update...'
    ;;
*)
    echo 'Invalid input. Was it mistyping?'
    exit 1
    ;;
esac

# play
case "$1" in
    ask)
        vault_args=('--ask-vault-pass')
    ;;
    *)
        vault_args=('--vault-pass-file' "$1")
    ;;
esac

shift 1

# config
export ANSIBLE_NOCOWS=1
export ANSIBLE_JINJA2_EXTENSIONS='jinja2.ext.do'

# ansible-playbook -i ./inventory -c local test.yml "${vault_args[@]}" "$@"
ansible-playbook -i ./inventory -c local config.yml "${vault_args[@]}" "$@"

echo
echo 'NEED RESTART?..'
sudo needrestart -m a -r l
