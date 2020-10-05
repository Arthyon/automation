- Follow the [installation guide](https://wiki.archlinux.org/index.php/installation_guide) normally
- Reboot and log in as root
- Add wheel to sudoers
- Connect to the internet
- Clone repo
- Install Ansible `pacman -Syu python ansible`
- Add plugins: `ansible-galaxy install kewlfft.aur`
- Add collections: `ansible-galaxy collection install community.general`
- Run playbook: `ansible-playbook site.yml`
- Set password for your user: `passwd <your-user>`
- Reboot

Place an image in `/home/{{ archlinux_username }}/.wallpaper` to set background.

Edit `bg`-property in `/etc/lxdm/lxdm.conf` to set background for login manager.
Replace `/usr/share/lxdm/themes/Industrial/login.png` to change logo for login manager.
