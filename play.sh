#!/usr/bin/env bash

ansible-playbook -i hosts.yml install.yml -e@.vars.yml --ask-vault-pass
