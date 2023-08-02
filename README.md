# Setup

## Installing Arch

- Download archinstall config: `curl https://raw.githubusercontent.com/Arthyon/automation/master/user_configuration.json --output user_configuration.json`
- Change info to match current setup
- Run archinstall `archinstall --config user_configuration.json`

## Run Ansible

- Clone repo
- Update keyring: `pacman -Syu archlinux-keyring`
- Add requirements: `ansible-galaxy install -r requirements.yml`
- Run playbook: `ansible-playbook setup.yml`
  - Answer prompts
  - Wait a while ...
- Set password for your user: `passwd <your-user>`
- Reboot

# Postinstall

## General setup

- Run `run_jottad` to set up jotta cli
- Copy wireguard config to `/etc/wireguard/<myclient>.conf`
- Configure global git config (user, email, gpg key)

## Background images

- Place an image in `/home/{{ archlinux_username }}/.wallpaper` to set background.

- Edit `bg`-property in `/etc/lxdm/lxdm.conf` to set background for login manager. Make sure this is placed somewhere like `/usr/share/lxdm/backgrounds/` to enable the login process to access the file.
- Replace `/usr/share/lxdm/themes/Industrial/login.png` to change logo for login manager.

## Performance

- Set scheduler based on drive type

  - https://wiki.archlinux.org/title/Improving_performance#Changing_I/O_scheduler

## Backups

Set up snapper (TODO)

## Polybar

- On desktops: Remove polybar battery module from the bars
- On machines without bluetooth: Remove polybar bluetooth module from bar

# Additional features

Additional features can optionally be set up.

Use the playbook `features.yml` and scope using tags.

**NOTE**: Run as your own user, not root.

- For a list of all available tags, run:
  - `ansible-playbook features.yml --list-tags`.
- Set up features:
  - `ansible-playbook features.yml --tags "feature1,feature2" --ask-become-pass`

# Troubleshooting

## Audio issues

- Set default audio sink/source:

  - `pactl list short [sinks|sources]`
  - `pactl set-default-sink <my sink>`
  - `pactl set-default-source <my source>`

## Polybar issues

- If polybar wlan indicator does not work, replace interface name in polybar wlan module with your interface name

# Thunderbolt

To be able to use all usb ports on connected thunderbolt screens, add `pci=hpbussize=0x33` as kernel argument to boot entry (`boot/loader/entries/*.conf`)
