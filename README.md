# Configuration Files

> [!NOTE]
> This configuration is specifically optimized to work with [my custom keyboard / layout](https://github.com/minusfive/zmk-config). If you want to use it, you'll likely want to make some changes.

<img alt="Workspace" src="./assets/workspace.png" width="100%"/>

## Bootstrap

To setup a new machine run [the bootstrap script](./scripts/bootstrap.zsh):

```sh
git clone git@github.com:minusfive/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
source ./scripts/bootstrap.zsh
```

Read [the bootstrap script](./scripts/bootstrap.sh) to understand what it does, and what's installed, as well as the [Nix Flake](./.config/nix-darwin/flake.nix).

## Update

> [!IMPORTANT]\
> `Wezterm` must be granted "Application Management" access so this script is allowed to update all managed applications.
>
> `System Preferences > Security & Privacy > Application Management`

To update an already bootstrapped system (i.e. all installed tools/apps), run [the update script](./scripts/update.zsh):

```sh
cd ~/.dotfiles
source ./scripts/update.zsh
```

> [!NOTE]
> The [bootstrap](#bootstrap) script will run this script at the end of its execution, so no need to run it separately after bootstrapping.

## Link

To only link the configuration files (i.e. without installing any tools/apps), run [the link script](./scripts/link.zsh):

```sh
cd ~/.dotfiles
./scripts/link.zsh
```

> [!NOTE]
> The [bootstrap](#bootstrap) and [update](#update) scripts will run this script, so no need to run it separately after bootstrapping or updating.

## Tools

- [Nix](https://nixos.org/) - OS Configuration, Package Manager
  - [Nix Darwin](https://github.com/LnL7/nix-darwin) - macOS Nix
- [Neovim](https://neovim.io/) - Text Editor / IDE
  - [LazyVim](https://www.lazyvim.org/) - Neovim Plugin and Configuration Manager
  - See [the Neovim configuration](./.config/nvim) for the full list of installed plugins and settings.
- [Hammerspoon](https://www.hammerspoon.org/) - macOS Automation (app launcher, window / system manager, etc.)
- [WezTerm](https://wezfurlong.org/wezterm/) - Terminal Emulator
- [Homebrew](https://brew.sh) - macOS Package Manager
- [GNU Stow](https://www.gnu.org/software/stow/) - Symlink Manager
- [GNU Coreutils](https://www.gnu.org/software/coreutils/) - Core Utilities
- [Zsh](https://www.zsh.org/) - Shell
- [Oh My Zsh](https://ohmyz.sh/) - Zsh Configuration Manager
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) - Zsh Theme
- [Yazi](https://github.com/sxyazi/yazi) - File Manager Terminal UI
- [fzf](https://github.com/junegunn/fzf) - Fuzzy Finder
- [lazygit](https://github.com/jesseduffield/lazygit) - Git Terminal UI
- [fd](https://github.com/sharkdp/fd) - Better `find`
- [ripgrep](https://github.com/BurntSushi/ripgrep) - Better `grep`
- [bat](https://github.com/sharkdp/bat) - Better `cat`
- [zoxide](https://github.com/ajeetdsouza/zoxide) - Better `cd`
- [htop](https://github.com/htop-dev/htop) - Better `top`
- [eza](https://github.com/eza-community/eza) - Better `ls`
- [Catppuccin](https://catppuccin.com/) - Color scheme for everything
