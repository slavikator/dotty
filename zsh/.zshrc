export XDG_CONFIG_HOME="$HOME/.config"
export PATH="$HOME/bin/nvim/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export GOOGLE_CLOUD_PROJECT="next-475218"

alias tmux='tmux -f "$XDG_CONFIG_HOME/tmux/tmux.conf"'
PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"
export PATH


# Файл, де зберігається історія
HISTFILE=~/.zsh_history

# Кількість команд для зберігання в історії
HISTSIZE=10000
SAVEHIST=10000

# Опції для роботи з історією
setopt INC_APPEND_HISTORY       # одразу записує команди у файл
setopt SHARE_HISTORY            # ділиться історією між кількома сесіями
setopt HIST_IGNORE_DUPS         # не дублює однакові команди
setopt HIST_IGNORE_SPACE        # не додає команд, які починаються з пробілу
setopt HIST_VERIFY              # показує команду перед виконанням, якщо взято з історії

# fzf інтеграція
# Запусти офіційний інсталятор fzf (через Homebrew):
# $(brew --prefix)/opt/fzf/install

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if command -v fzf >/dev/null; then
  bindkey '^R' fzf-history-widget
fi

# zoxide
eval "$(zoxide init zsh)"
