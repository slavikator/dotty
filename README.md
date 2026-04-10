# dotty

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Setup on a new machine

### 1. Install Stow

```sh
brew install stow
```

### 2. Clone the repo

```sh
git clone https://github.com/slavikator/dotty.git ~/dotty
cd ~/dotty
```

### 3. Stow configs

Each directory maps to `$HOME`. Symlink everything at once:

```sh
stow nvim zsh ghostty alacritty yazi
```

Or individual tools:

```sh
stow nvim
```

### 4. Neovim

Install [Neovim](https://neovim.io/) and open it — [lazy.nvim](https://github.com/folke/lazy.nvim) will bootstrap itself and install all plugins automatically.

Mason will auto-install LSP servers (`emmet-language-server`, `tailwindcss-language-server`) on first launch.

### Dependencies

| Tool | Install |
|------|---------|
| Neovim ≥ 0.10 | `brew install neovim` |
| Ghostty | [ghostty.org](https://ghostty.org) |
| Alacritty | `brew install --cask alacritty` |
| Yazi | `brew install yazi` |
| fzf | `brew install fzf && $(brew --prefix)/opt/fzf/install` |
| zoxide | `brew install zoxide` |
| MesloLGL Nerd Font | `brew install --cask font-meslo-lg-nerd-font` |
