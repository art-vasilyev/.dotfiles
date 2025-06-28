# Dotfiles

## Requirements
```bash
brew install stow
```

## Installation

```bash
# clone repository
git clone https://github.com/art-vasilyev/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# symlink configs with stow
stow brew ghostty zsh tmux nvim karabiner

# install packages
brew bundle --file=~/Brewfile
```

## Extra steps

# zsh

Install  oh-my-zsh: https://ohmyz.sh/#install

# tmux

Install plugin manager:
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

# karabiner

Start karabiner and configure permissions.

## Update
```bash
cd ~/.dotfiles
git pull
stow -R nvim zsh tmux ghostty brew
