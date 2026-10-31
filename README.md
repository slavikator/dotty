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

Plugin versions are pinned in `lazy-lock.json` (committed), so every machine gets the same versions. Update them on purpose with `:Lazy update`, then commit the lock file.

**LazyVim extras** (enabled in `lazyvim.json`, manage with `:LazyExtras`): `coding.luasnip`, `coding.mini-surround`, `formatting.prettier`, `lang.terraform`, `lang.yaml`, `lang.json`, `lang.markdown`, `lang.docker`. They bring language servers, format on save and linting:

| Files | Tools |
|---|---|
| Terraform (`.tf`) | `terraform-ls`, `tflint`, format on save with `terraform fmt` |
| YAML, GitHub Actions workflows | `yaml-language-server` with SchemaStore schemas, `actionlint` (only in `.github/workflows/`) |
| Shell scripts (`az` CLI) | `bash-language-server`, `shellcheck`, `shfmt` |
| JSON, Markdown, Dockerfiles | `json-lsp`, `marksman`, `markdownlint-cli2`, `dockerfile-language-server`, `hadolint` |
| Web | `emmet-language-server`, `tailwindcss-language-server` |

Mason installs these tools on the first launch after they're added (see `lua/plugins/mason.lua` and `lua/plugins/devops.lua`). Open `:Mason` to check them.

To use Mason's tools outside Neovim too (e.g. `tflint` before a commit), add them to `PATH`:

```sh
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
```

## After changing a config

Packages are symlinked as whole folders where possible (e.g. `~/.config/nvim` → `~/dotty/nvim/.config/nvim`), so new files inside them land in this repo automatically. Just commit and push:

```sh
cd ~/dotty && git status && git add -A && git commit -m "..." && git push
```

Run `stow` again only for a new package, or for a new file placed directly in `$HOME` inside a package (`stow -R <package>`). Preview first with `stow -n -v <package>`.

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
