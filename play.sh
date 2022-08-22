#!/usr/bin/env bash

set -Eeuo pipefail

: "${1:?provide argument to script - path to the file with vault password or \`ask\`}"

read -rn1 -p 'Run system and flatpak update? [Y/n] ' yn

if [[ -n "$yn" ]]; then
    echo
fi

case "$yn" in
[Yy] | '')
    set -x
    sudo paru -Syu
    sudo flatpak update
    set +x
    ;;
[Nn])
    echo 'Skipping system and flatpak update...'
    ;;
*)
    echo 'Invalid input. Was it mistyping?'
    exit 1
    ;;
esac

export ANSIBLE_NOCOWS=1

# play
case "$1" in
    ask)
        vault_args=('--ask-vault-pass')
    ;;
    *)
        vault_args=('--vault-pass-file' "$1")
    ;;
esac

ansible-playbook -i hosts.yml config.yml -e@.vars.yml "${vault_args[@]}"

# need restart ?
/usr/bin/needrestart -b | { /usr/bin/grep --color=always -E '((KSTA|UCSTA): [023])|SVC:|SESS:' || /usr/bin/test $? = 1; }
