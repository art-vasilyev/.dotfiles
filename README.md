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

Clone oh-my-zsh:
```bash
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
```

Clone zsh-autosuggestions plugin:
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

Set zsh as the default shell:
```bash
chsh -s $(which zsh)
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
