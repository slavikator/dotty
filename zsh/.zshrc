export XDG_CONFIG_HOME="$HOME/.config"
export PATH="$HOME/bin/nvim/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export GOOGLE_CLOUD_PROJECT="next-475218"

alias tmux='tmux -f "$XDG_CONFIG_HOME/tmux/tmux.conf"'
PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"
export PATH
