# Setup

- Follow the [installation guide](https://wiki.archlinux.org/index.php/installation_guide) normally
  - Recommended packages to pacstrap: `sudo`, `iwd` and `dhcpcd`
- Reboot and log in as root
- Add wheel to sudoers using `visudo`
- Connect to the internet
  ```
  systemctl start iwd dhcpcd
  iwctl
  [iwctl] device list
  [iwctl] station <dev> connect <ssid>
  ```
- Clone repo
- Install Ansible: `pacman -Syu python ansible`
- Add plugins: `ansible-galaxy install kewlfft.aur`
- Add collections: `ansible-galaxy collection install community.general`
- Run playbook: `ansible-playbook setup.yml`
- Wait a while
- Set password for your user: `passwd <your-user>`
- Enable login manager: `systemctl enable lxdm`
- Reboot

# Post setup

- Place an image in `/home/{{ archlinux_username }}/.wallpaper` to set background.

- Edit `bg`-property in `/etc/lxdm/lxdm.conf` to set background for login manager.
  Replace `/usr/share/lxdm/themes/Industrial/login.png` to change logo for login manager.

- If using ZFS:
  - Update `/usr/local/bin/pacman-snapshots.sh` with your datasets.
