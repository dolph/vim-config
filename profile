#!/bin/sh

# Switch sh to vi mode, because the sh default is unholy.
set -o vi

# Use color by default.
export CLICOLOR=1

if [ ! -e "$HOME/.gitconfig" ]
then
    # This doesn't need to be enabled every time, but why not?
    git config --global color.ui true
    git config --global user.email "dolph.mathews@gmail.com"
    git config --global user.name "Dolph Mathews"
    git config --global core.excludesfile $HOME/.gitignore_global
fi

# Launch keychain to manage SSH passphrases.
if command -v keychain >/dev/null 2>&1 ; then
    eval `keychain --quiet --eval id_rsa`
fi

# Detect platform ($OSTYPE is not populated in FreeBSD 11).
case "$(uname -s)" in
Linux|Darwin)
    # Go
    export GOPATH=$HOME/go
    export PATH="$PATH:$GOPATH/bin:/usr/local/go/bin"

    # Rust
    export RUSTPATH=$HOME/.cargo/bin
    export PATH="$HOME/.cargo/bin:$PATH"
    ;;
FreeBSD)
    ;;
esac
