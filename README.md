# Setup

## Installing Arch

- Enable network
  - `iwctl`
  - `[iwd]# station <wlan> scan`
  - `[iwd]# station <wlan> connect <ssid>`
- Download archinstall config: `curl https://raw.githubusercontent.com/Arthyon/automation/master/user_configuration.json --output user_configuration.json`
- Change info to match current setup
- Run archinstall `archinstall --config user_configuration.json`
  - Set up user and disk layout
- Reboot

## Run Ansible

- Clone repo
- Add requirements: `ansible-galaxy install -r requirements.yml`
- Run playbook: `ansible-playbook setup.yml --ask-become-pass`
  - Wait a while ...
  - **NOTE**: If any aur-installations take more time than sudo's `passwd_timeout` you may be prompted for password during installation
- Reboot

# Postinstall

## General setup

- Set up JottaCloud
  - `run_jottad` 
  - `jotta-cli login`
  - `jotta-cli sync setup --root ~/JottaCloud`
  - `jotta-cli sync start`

- Copy wireguard config to `/etc/wireguard/<myclient>.conf`

- Configure global git config:
  - `git config --global user.name "<name>"`
  - `git config --global user.email "<email>"`

- Configure gpg:
  - If needed, create new: `gpg --full-generate-key`
  - `gpg --list-secret-keys --keyid-format=long`
  - `git config --global user.signingkey <keyid>`
  - `git config --global commit.gpgsign true`
  - Export public key: `gpg --armor --export <keyid> | xclip`

- Set up default autorandr profile
  - `autorandr --save undocked`
  - `autorandr --default undocked`


## Background images

- Place an image in `$HOME/.wallpaper` to set background.
- Place an image in `/usr/share/lxdm/.background` to set background.
- Replace `/usr/share/lxdm/themes/Industrial/login.png` to change logo for login manager.

## Backups

If using the default btrfs-setup from `archinstall`:
```
sudo umount /.snapshots
sudo rm -r /.snapshots
sudo snapper -c root create-config /
sudo btrfs subvolume delete /.snapshots
sudo mkdir /.snapshots
```

- Add fstab entry for the snapshot directory created by `archinstall`.
- `sudo chmod 750 /.snapshots`


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

## Thunderbolt

- If not all usb ports on a screen is recognized, add `pci=hpbussize=0x33` as kernel argument to boot entry (`boot/loader/entries/*.conf`)
- If a screen refuses to be identified, run `xset dpms force off`

## Not using correct DNS server

This should be fixed permanently!

`systemctl restart systemd-resolved`
