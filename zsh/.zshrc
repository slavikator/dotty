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


export PATH="$HOME/.local/bin:$PATH"

# Android SDK platform-tools
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"


# =================================================================
# --- 16GB M1 PRO OPTIMIZED OLLAMA CONFIG (STABILIZED) ---
# =================================================================

# --- PERFORMANCE ---
export OLLAMA_CONTEXT_LENGTH=32768
export OLLAMA_METAL=1
export OLLAMA_FLASH_ATTENTION=1
export OLLAMA_KEEP_ALIVE=3h

# --- THE CLOUD FLEET (FREE TIER VERIFIED) ---

# [ga] - THE ARCHITECT (Qwen 3.5 397B)
# The "Heavy Lifter." Use for high-level logic, complex system design, 
# and multi-step reasoning. Your most powerful planning model.
alias ga='ollama launch claude --model qwen3.5:397b-cloud -- --permission-mode auto --dangerously-skip-permissions'

# [gx] - THE FIXER (Qwen3-Coder Next)
# The "Coding King." Specifically tuned for agentic execution, 
# debugging, and writing code. This is your primary engineering tool.
alias gx='ollama launch claude --model qwen3-coder-next:cloud -- --permission-mode auto --dangerously-skip-permissions'

# [gg] - THE DAILY DRIVER (Gemma 4 31B)
# The "Reliable Specialist." Your verified daily driver for 
# general questions, shell scripts, and rapid-fire explanations.
alias gg='ollama launch claude --model gemma4:31b-cloud -- --permission-mode auto --dangerously-skip-permissions'

# [gd] - THE ANALYST (Kimi K2.5)
# The "Context King." Best for reading massive repositories, 
# log files, and repo-wide documentation analysis.
alias gd='ollama launch claude --model kimi-k2.5:cloud -- --permission-mode auto --dangerously-skip-permissions'

# --- THE LOCAL FALLBACKS (Zero Quota Impact) ---

# [gl] - LOCAL AGENT (Gemma 4 4B)
# Full agentic capabilities running locally on your M1 Pro GPU.
alias gl='ollama launch claude --model gemma4:e4b -- --permission-mode auto --dangerously-skip-permissions'

# [g] - QUICK CHAT (Gemma 4 4B)
alias g='ollama run gemma4:e4b'
