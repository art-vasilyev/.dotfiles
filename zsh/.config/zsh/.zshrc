# ~/.zshrc

# ---------- history ----------

HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt EXTENDED_HISTORY
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

# ---------- shell behavior ----------

setopt nobeep
setopt numeric_glob_sort
setopt interactivecomments

WORDCHARS="*?[]~=&;!#$%^(){}<>"

# -------- edit command line ---------

EDITOR=nvim
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# ---------- completion ----------

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

bindkey '^I' expand-or-complete

# ---------- tools ----------

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"

if [[ -d "$PYENV_ROOT/bin" ]]; then
  export PATH="$PYENV_ROOT/bin:$PATH"
fi

eval "$(pyenv init - zsh)"

# zoxide
eval "$(zoxide init zsh)"

# fzf
source <(fzf --zsh)
export FZF_DEFAULT_OPTS="
--height 50%
--layout=reverse
--border
--ansi
"

# starship
eval "$(starship init zsh)"

# ---------- plugins ----------

ZSH_PLUGIN_DIR="$HOME/.config/zsh/plugins"
ZSH_AUTOSUGGESTIONS_DIR="$ZSH_PLUGIN_DIR/zsh-autosuggestions"

mkdir -p "$ZSH_PLUGIN_DIR"

# Install zsh-autosuggestions automatically
if [[ ! -d "$ZSH_AUTOSUGGESTIONS_DIR" ]]; then
  git clone \
    https://github.com/zsh-users/zsh-autosuggestions \
    "$ZSH_AUTOSUGGESTIONS_DIR"
fi

source "$ZSH_AUTOSUGGESTIONS_DIR/zsh-autosuggestions.zsh"

# Autosuggestion tuning
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=1

# ---------- keybindings ----------

# Ctrl-R -> fuzzy history search
bindkey '^R' fzf-history-widget

# ---------- aliases ----------

alias vim="nvim"
alias v="nvim"

alias ls="eza --icons=always"
alias l="ls"
alias ll="ls -lh"

alias bat="bat --style=plain"
alias cat="bat"

alias tf="terraform"

# ---------- local overrides ----------

[[ -f ~/.config/zsh/.zshrc.local ]] && \
  source ~/.config/zsh/.zshrc.local

# ------ env vars --------

[[ -f ~/.config/zsh/.zshenv ]] && \
  source ~/.config/zsh/.zshenv
