# Configuration Files

> [!IMPORTANT]
> This configuration is specifically optimized to work with [my custom keyboard / layout](https://github.com/minusfive/zmk-config). If you want to use it, you'll likely want to make some changes.

<img alt="Workspace" src="./assets/workspace.png" width="100%"/>

## Usage

```sh
# clone this repo to a directory inside your $HOME (~) directory
git clone git@github.com:minusfive/dotfiles.git ~/.dotfiles
# go into this repo directory
cd ~/.dotfiles
```

### Bootstrap

To setup a new machine (or refresh/reset an existing one), run the following script:

```sh
./scripts/bootstrap.sh
```

Read [the script](./scripts/bootstrap.sh) to understand what it does, and [the Brewfile](./scripts/Brewfile) to see what apps it installs.

### Refresh

Alternatively, if you only want to refresh the configuration files, run:

```sh
./scripts/refresh.sh
```

## Tools

- [Hammerspoon](https://www.hammerspoon.org/) - macOS Automation Tool (app launcher, window manager, caffeinator, etc.)
- [WezTerm](https://wezfurlong.org/wezterm/) - Terminal Emulator
- [Homebrew](https://brew.sh) - macOS Package Manager
- [Zsh](https://www.zsh.org/) - Shell
  - [Yazi](https://github.com/sxyazi/yazi) - File Manager
  - [fzf](https://github.com/junegunn/fzf) - Fuzzy Finder
  - [fd](https://github.com/sharkdp/fd) - Better `find`
  - [ripgrep](https://github.com/BurntSushi/ripgrep) - Search Tool
  - [GNU Stow](https://www.gnu.org/software/stow/) - Symlink Manager
  - [lazygit](https://github.com/jesseduffield/lazygit) - Git Terminal UI
  - [bat](https://github.com/sharkdp/bat) - Better `cat`
  - [zoxide](https://github.com/ajeetdsouza/zoxide) - Better `cd`
  - [htop](https://github.com/htop-dev/htop) - Better `top`
  - [Oh My Zsh](https://ohmyz.sh/) - Zsh Configuration Manager
  - [Powerlevel10k](https://github.com/romkatv/powerlevel10k) - Zsh Theme
  - [eza](https://github.com/eza-community/eza) - Better `ls`
  - See [the Brewfile](./scripts/Brewfile) and [the bootstrap script](./scripts/bootstrap.sh) for the full list of installed tools, apps, themes, plugins, etc.
- [Neovim](https://neovim.io/) - Text Editor / IDE
  - [LazyVim](https://www.lazyvim.org/) - Neovim Plugin and Configuration Manager
  - See [the Neovim configuration](./.config/nvim) for the full list of installed plugins and settings.
