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
stow brew ghostty fish tmux nvim karabiner

# install packages
brew bundle --file=~/Brewfile
```

## Extra steps

# fish

Install fzf.fish plugin:
```bash
fisher install PatrickF1/fzf.fish
```

Set fish as the default shell:
```bash
chsh -s $(which fish)
```

# tmux

Clone plugin manager:
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Run tmux and install plugins:
```
<prefix>+I
```

# karabiner

Start karabiner and configure permissions.

## Update
```bash
cd ~/.dotfiles
git pull
stow -R nvim zsh tmux ghostty brew
