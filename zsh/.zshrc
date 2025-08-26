export ZSH="$HOME/.oh-my-zsh"

plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# accept/clear suggestions by ctrl-y/e like in neovim
bindkey '^y' autosuggest-accept
bindkey '^e' autosuggest-clear

# store secrets separately
if [ -f ~/.config/zsh/.envrc ]; then
    source ~/.config/zsh/.envrc
fi

# ---- pyenv ----
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export PATH="$HOME/.local/bin/:$PATH"

# ---- fzf ----

eval "$(fzf --zsh)"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git --exclude .tox"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# ---- Eza ----

alias ls="eza --icons=always"

# ---- aliases ----

alias vim="nvim"
alias v="nvim"

# ---- zoxide ----

eval "$(zoxide init zsh)"

# ---- bat ----

alias bat="bat --style plain"

# ---- starship prompt ----
eval "$(starship init zsh)"

# zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# config overrides

if [[ -f ~/.config/zsh/.zshrc.local ]]; then
    source ~/.config/zsh/.zshrc.local
fi
