#!/usr/bin/env bash

set -Eeuo pipefail

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
