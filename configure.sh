#!/bin/bash

NAME="Eugene Sun"
EMAIL="eug.sun@gmail.com"
SETUP_ZSH=true
SETUP_SSH_KEY=true

# Set up homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install ansible

# Change shell to zsh
if [ "$SETUP_ZSH" = true ]; then
    brew install zsh
    echo "/usr/local/bin/zsh" | sudo tee -a /etc/shells
    chsh -s /usr/local/bin/zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# SSH Credential
if [ "$SETUP_SSH_KEY" = true ]; then
    ssh-keygen -t rsa -b 4096 -C "$EMAIL"
    eval "$(ssh-agent -s)"
    ssh-add $HOME/.ssh/id_rsa
    ssh-add -K $HOME/.ssh/id_rsa
    pbcopy < $HOME/.ssh/id_rsa.pub
    echo "SSH pub key copied to clipboard.\nGo paste it at github.com, and then press any key to continue..."
    read
fi
