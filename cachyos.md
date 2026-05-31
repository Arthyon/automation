# Setup

## Installing CachyOS

Install normally, selecting Cosmic as the DE.

## Run Ansible

- Clone repo
- Add requirements: `ansible-galaxy install -r requirements.yml`
- Run playbook: `ansible-playbook setup.yml --ask-become-pass`
  - Wait a while ...
- Done

# Postinstall

## General setup

- Set up JottaCloud

  - `run_jottad`
  - `jotta-cli login`
  - `jotta-cli sync setup --root /path/to/sync-folder`
  - `jotta-cli sync start`

- Configure global git config:

  - `git config --global user.name "<name>"`
  - `git config --global user.email "<email>"`

# Troubleshooting

## Not using correct DNS server

This should be fixed permanently!

`systemctl restart systemd-resolved`