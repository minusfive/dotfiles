# Configuration Files

> [!IMPORTANT]
> This configuration is specifically optimized to work with [my custom keyboard / layout](https://github.com/minusfive/zmk-config). If you want to use it, you'll likely want to make some changes.

<img alt="Workspace" src="./assets/workspace.png" width="100%"/>

## Core Tools

- **Terminal**:
  - [WezTerm](https://wezfurlong.org/wezterm/)
- **Shell**:
  - [Zsh](https://www.zsh.org/)
  - [Oh My Zsh](https://ohmyz.sh/)
  - [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- **Editor**:
  - [Neovim](https://neovim.io/)
  - [LazyVim](https://www.lazyvim.org/)
- **Window Management, App Launcher, OS Automation:**:
  - [Hammerspoon](https://www.hammerspoon.org/)
- [**Bootstrapping**](#bootstrap):

  - [GNU Stow](https://www.gnu.org/software/stow/)
  - [Homebrew](https://brew.sh)

- ... see [scripts/bootstrap.sh](./scripts/bootstrap.sh) and [scripts/Brewfile](./scripts/Brewfile) for the full list.

## Bootstrap

```sh
# clone this repo to a directory inside your $HOME (~) directory
git clone git@github.com:minusfive/dotfiles.git ~/.dotfiles
# go into this repo directory
cd ~/.dotfiles
# run bootstrap script to install core tools / apps
./scripts/bootstrap.sh
```

## To Do

- [ ] Improve this README file
