#!/usr/bin/env bash

set -Eeuo pipefail

# install prerequisites
# ansible-galaxy collection install -r requirements.yml

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
