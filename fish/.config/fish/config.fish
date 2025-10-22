# disable greeting
set -g fish_greeting

# ---- PATH additions ----
set -x PATH /opt/homebrew/bin/  $HOME/.local/bin $PATH
if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    pyenv init - fish | source
    zoxide init fish | source
end

# ---- Store secrets separately ----
if test -f ~/.config/fish/.envrc
    source ~/.config/fish/.envrc
end

# ---- fzf ----
set -x FZF_DEFAULT_COMMAND "fd --hidden --strip-cwd-prefix --exclude .git --exclude .tox"
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

# ---- aliases ----
alias vim="nvim"
alias v="nvim"
alias ls="eza --icons=always"
alias l="ls"
alias bat="bat --style plain"

# ---- local overrides ----
if test -f ~/.config/fish/.fishrc.local
    source ~/.config/fish/.fishrc.local
end
