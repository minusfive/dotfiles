# Personal System Config

To setup a new machine or update a current one, run:

```sh
git clone git@github.com:minusfive/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./scripts/bootstrap.zsh
```

> [!WARNING]
> This will modify system settings and install software. You should read and understand [the bootstrap script](./scripts/bootstrap.zsh) and [Nix Flake](./flake.nix) before proceeding.

> [!NOTE]
> This configuration includes several keyboard shortcuts (for app launching, window management, text editing, etc.), optimized to work with [my custom keyboard layout](https://github.com/minusfive/zmk-config) and workflow. To customize you'll likely want to primarily look at the following configurations:
>
> - [Hammerspoon](./.config/hammerspoon/)
> - [Wezterm](./.config/wezterm/)
> - [NeoVim](./.config/nvim/)

## Programs

OS configuration and software installation + management is handled by [Nix](https://nixos.org/), using the [nix-darwin](https://github.com/LnL7/nix-darwin) (macOS) and [Home Manager](https://github.com/nix-community/home-manager) (user configuration) modules, with some help from [Homebrew](https://brew.sh) (for macOS GUI apps) and [GNU Stow](https://www.gnu.org/software/stow/) (for management of mutable symlinks).

These are the [programs](./nix/programs/) currently installed by Nix and Homebrew on my machine:

<https://github.com/minusfive/dotfiles/blob/0ef25b1edbebf4ca703c31045c08a31ed0da6adc/nix/users/minusfive/aarch64-darwin.nix#L3-L42>

<img alt="Workspace" src="./assets/workspace.png" width="100%"/>
