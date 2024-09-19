# Configuration Files

> [!NOTE]
> This configuration is specifically optimized to work with [my custom keyboard / layout](https://github.com/minusfive/zmk-config). If you want to use it, you'll likely want to make some changes.

<img alt="Workspace" src="./assets/workspace.png" width="100%"/>

## Bootstrap

To setup a new machine (or refresh/reset an existing one), run the following script:

```sh
git clone git@github.com:minusfive/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./scripts/bootstrap.sh
```

Read [the script](./scripts/bootstrap.sh) to understand what it does, and [the Brewfile](./scripts/Brewfile) to see what apps it installs.

## Update

> [!IMPORTANT]
> You should grant `Wezterm` "Application Management" access in `System Preferences > Security & Privacy > Application Management` so this script is allowed to update all managed applications.

To update the configuration and all installed tools/apps, simply run the same script:

```sh
cd ~/.dotfiles
./scripts/bootstrap.sh
```

## Tools

- [Neovim](https://neovim.io/) - Text Editor / IDE
  - [LazyVim](https://www.lazyvim.org/) - Neovim Plugin and Configuration Manager
  - See [the Neovim configuration](./.config/nvim) for the full list of installed plugins and settings.
- [Hammerspoon](https://www.hammerspoon.org/) - macOS Automation Tool (app launcher, window manager, caffeinator, etc.)
- [WezTerm](https://wezfurlong.org/wezterm/) - Terminal Emulator
- [Homebrew](https://brew.sh) - macOS Package Manager
  - See [the Brewfile](./scripts/Brewfile) and [the bootstrap script](./scripts/bootstrap.sh) for the full list of installed tools, apps, themes, plugins, etc.
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
