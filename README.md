# System Configuration and Automation

## Bootstrap and Update

To setup a new machine or update a current one, run:

```sh
git clone git@github.com:minusfive/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./scripts/bootstrap.zsh
```

> [!WARNING]
> This will modify system settings and install software. You should read and understand [the bootstrap script](./scripts/bootstrap.zsh) and [Nix Flake](./flake.nix) before proceeding.

> [!NOTE]
> This configuration includes several keyboard shortcuts specifically optimized to work with [my custom keyboard layout](https://github.com/minusfive/zmk-config) (for app launching, window management, text editing, etc.). To customize those to your preference you'll likely want to make some changes to the following configurations (primarily):
>
> - [Hammerspoon](./.config/hammerspoon/)
> - [Wezterm](./.config/wezterm/)
> - [NeoVim](./.config/nvim/)

### Programs

#### Nix, nix-darwin and Home Manager

Primary OS configuration and software installation + management is handled by [Nix](https://nixos.org/), using the [nix-darwin](https://github.com/LnL7/nix-darwin) (macOS) and [Home Manager](https://github.com/nix-community/home-manager) (user configuration) modules, with some help from [Homebrew](https://brew.sh) (macOS package manager) and [GNU Stow](https://www.gnu.org/software/stow/) (symlink manager).

These are the [programs](./nix/programs/) currently installed by Nix on my machine:

<https://github.com/minusfive/dotfiles/blob/51cf975a5c392a0a73fd74730ceb11e1fa0ed3a6/nix/users/minusfive/aarch64-darwin.nix#L3-L39>

<img alt="Workspace" src="./assets/workspace.png" width="100%"/>
