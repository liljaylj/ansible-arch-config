#!/usr/bin/env bash

# install prerequisites
ansible-galaxy collection install -r requirements.yml

# play
ansible-playbook -i hosts.yml config.yml -e@.vars.yml --ask-vault-pass
