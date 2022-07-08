# Setup

- Follow the [Arch installation guide](https://wiki.archlinux.org/index.php/installation_guide) normally
  - Recommended packages to pacstrap: `sudo`, `iwd` and `gvim`
- Reboot and log in as root
- Add wheel to sudoers using `visudo`
- Connect to the internet
  ```console
  # systemctl start iwd dhcpcd
  # iwctl
  # [iwctl] device list
  # [iwctl] station <dev> connect <ssid>
  ```
- Clone repo
- Update keyring: `pacman -Syu archlinux-keyring`
- Install Ansible and dependencies: `pacman -S python python-pip python-virtualenv ansible`
- Add requirements: `ansible-galaxy install -r requirements.yml`
- Run playbook: `ansible-playbook setup.yml`
  - Answer prompts
  - Wait a while ...
- Set password for your user: `passwd <your-user>`
- Reboot

# Postinstall

- Place an image in `/home/{{ archlinux_username }}/.wallpaper` to set background.

- Edit `bg`-property in `/etc/lxdm/lxdm.conf` to set background for login manager. Make sure this is placed somewhere like `/usr/share/lxdm/backgrounds/` to enable the login process to access the file.
  Replace `/usr/share/lxdm/themes/Industrial/login.png` to change logo for login manager.

- If using ZFS:

  - Update `/usr/local/bin/pacman-snapshots.sh` with your datasets.

- Set default audio sink/source:

  - `pactl list short [sinks|sources]`
  - `pactl set-default-sink <my sink>`
  - `pactl set-default-source <my source>`

- Set scheduler based on drive type

  - https://wiki.archlinux.org/title/Improving_performance#Changing_I/O_scheduler

- Run `run_jottad` to set up jotta cli
- Set up timeshift (`sudo timeshift-gtk` for easy setup)
- If polybar wlan indicator does not work, replace interface name in polybar wlan module with your interface name
- On desktops: Remove polybar battery module from the bars
- On machines with blueooth: Add polybar bluetooth module to bar
- Trust bitwarden installation ssl cert (`sudo trust anchor --store <certname>`)
- Copy wireguard config to `/etc/wireguard/<myclient>.conf`

# dotfiles

- After logging in as your user, run `ansible-playbook setup-dotfiles.yml` for other config.
