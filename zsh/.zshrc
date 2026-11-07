# ── Environment ──────────────────────────────────────────────────────────────
export XDG_CONFIG_HOME="$HOME/.config"
export GOOGLE_CLOUD_PROJECT="next-475218"

# Claude Code: no feedback survey, telemetry or error reporting
export CLAUDE_CODE_DISABLE_FEEDBACK_SURVEY=1
export DISABLE_TELEMETRY=1
export DISABLE_ERROR_REPORTING=1

# ── PATH ─────────────────────────────────────────────────────────────────────
# Keep entries unique, so nested shells (nvim terminal, tmux) don't pile up duplicates
typeset -U path PATH

path=(
  "$HOME/.local/bin"
  "$HOME/.local/share/nvim/mason/bin"         # LSPs/formatters installed by Mason
  "$HOME/Library/Android/sdk/platform-tools"  # adb, fastboot
  $path
)

# ── Node (nvm, lazy-loaded) ──────────────────────────────────────────────────
# Sourcing nvm.sh costs ~0.3s per shell. Instead, put the default Node version on
# PATH directly (so node/npm work everywhere, including tools started from nvim)
# and load nvm itself only the first time the `nvm` command is used.
export NVM_DIR="$HOME/.nvm"

if [[ -d "$NVM_DIR/versions/node" ]]; then
  _nvm_default=$(<"$NVM_DIR/alias/default" 2>/dev/null)
  _nvm_bin=("$NVM_DIR"/versions/node/v${_nvm_default#v}*/bin(N/On))   # matching version, newest first
  (( ${#_nvm_bin} )) || _nvm_bin=("$NVM_DIR"/versions/node/*/bin(N/nOn))  # fallback: newest installed
  (( ${#_nvm_bin} )) && path=("${_nvm_bin[1]}" $path)
  unset _nvm_default _nvm_bin
fi

nvm() {
  unfunction nvm
  [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
  [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
  nvm "$@"
}

# ── History ──────────────────────────────────────────────────────────────────
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt SHARE_HISTORY         # write each command immediately and share it between sessions
setopt EXTENDED_HISTORY      # save a timestamp and duration with each command
setopt HIST_IGNORE_ALL_DUPS  # drop older copies when a command is repeated
setopt HIST_IGNORE_SPACE     # don't save commands that start with a space
setopt HIST_REDUCE_BLANKS    # trim extra whitespace before saving
setopt HIST_VERIFY           # show a recalled command (e.g. !!) before running it

# ── Completion ───────────────────────────────────────────────────────────────
# Initialize once, before anything that registers completions
autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit  # enables bash-style `complete` (used by terraform)

command -v terraform >/dev/null && complete -o nospace -C "$(command -v terraform)" terraform

# ── Tools ────────────────────────────────────────────────────────────────────
# fzf: Ctrl-R history search, Ctrl-T file picker, Alt-C cd, ** completion
command -v fzf >/dev/null && source <(fzf --zsh)

# zoxide: keep last, as its docs require
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"
