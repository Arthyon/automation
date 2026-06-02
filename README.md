# Automation

Setup for my machines.

- Desktop: [CachyOS](cachyos.md)
- Laptop: Wayland+Sway (WIP)
- Old laptop: [Xorg+i3](archlinux.md) (not maintained)

## Additional features

Additional features can optionally be set up.

Use the playbook `features.yml` and scope using tags.

**NOTE**: Run as your own user, not root.

- For a list of all available tags, run:
  - `ansible-playbook features.yml --list-tags`.
- Set up features:
  - `ansible-playbook features.yml --tags "feature1,feature2" --ask-become-pass`
