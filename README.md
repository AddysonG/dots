# My Dotfiles

This directory contains most of my dotfiles. Some are cross-platform, and others are exclusive to certain software on Linux only. Software that have more complex configuration file structures are separated into separate repos that will be linked below. Some additional changes that are not stored any repos (usually due to using GUI configuration or living somewhere outside of the home directory) are noted.

## Installation

1. Clone this repo into your home directory.
2. Ensure the following directories exist if you intend to use them so Stow symlinks at the correct level:
    - `~/.claude`
    - `~/.vim`
    - `~/.config/kitty`
3. _(optional)_ Add `--ignore` lines into `~/.stowrc` for directories you don't need symlinked. Wrap in single quotes and escape periods. Example line: `--ignore='\.config/hypr'`
4. `cd` into the repo (e.g. `~/dots/`) and run `stow .` OR copy files manually if you don't want to apply all of them.

If any config files already exist on the machine, there are two options to resolve conflicts:

1. Run with the `--adopt` flag to "adopt" any conflicting files into the `dots` directory and replace them with the files on the current machine.
2. Remove conflicting files from the `~/` non-dots directory.

## Separated config repos

- Neovim: <https://github.com/AddysonG/nvim>
- VSCode: <https://github.com/AddysonG/vscode>

## Theming

- I use Breeze dark theme as a default for GTK and QT apps. There are packages for these, some of which need to be installed through the AUR on Arch.
- I use Papirus icon theme. Again, there are packages for this.

## IME

I use fcitx5 with some settings changed.

## Network manager

If on Arch, add `NetworkManager` as an additional package and do NOT carry over the configuration from the install script if using it, as doing so will require extra changes to switch the network manager.

## Claude Code

To set up integration with Herdr, launch Claude Code at least once, then:

```sh
herdr integration install claude
```

This write a `SessionStart` hook into `.claude/settings.json` as part of the setup process. Try to avoid adding that hook when committing.
