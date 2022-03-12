# Setup

- Follow the [Arch installation guide](https://wiki.archlinux.org/index.php/installation_guide) normally
  - Recommended packages to pacstrap: `sudo`, `iwd` and `dhcpcd`
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
- Install Ansible: `pacman -Syu python ansible`
- Add plugins: `ansible-galaxy install kewlfft.aur gantsign.visual-studio-code-extensions`
- Add collections: `ansible-galaxy collection install community.general`
- Run playbook: `ansible-playbook setup.yml`
  - Answer prompts
  - Wait a while ...
- Set password for your user: `passwd <your-user>`
- Reboot

# Postinstall

- Place an image in `/home/{{ archlinux_username }}/.wallpaper` to set background.

- Edit `bg`-property in `/etc/lxdm/lxdm.conf` to set background for login manager.
  Replace `/usr/share/lxdm/themes/Industrial/login.png` to change logo for login manager.

- If using ZFS:

  - Update `/usr/local/bin/pacman-snapshots.sh` with your datasets.

- Set default audio sink/source:

  - `pactl list short [sinks|sources]`
  - `pactl set-default-sink <my sink>`
  - `pactl set-default-source <my source>`

- Set scheduler based on drive

  - https://wiki.archlinux.org/title/Improving_performance#Changing_I/O_scheduler

- Terminal fonts in VS Code
  - Set Editor Font in settings to 'Fira Code' and linux terminal to 'termite'.
  - My xplat dotfiles are in another repo, so this setup does not include VS Code settings
