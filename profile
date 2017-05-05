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
    git config --global help.autocorrect 1
fi

# Launch keychain to manage SSH passphrases.
if command -v keychain >/dev/null 2>&1 ; then
    eval `keychain --quiet --eval id_rsa`
fi

# Detect platform ($OSTYPE is not populated in FreeBSD 11).
case "$(uname -s)" in
Linux|Darwin)
    export GOPATH=$HOME/go
    export RUSTPATH=$HOME/.cargo/bin
    export PATH=$HOME/bin:$RUSTPATH:/usr/local/bin:/usr/local/sbin:/usr/local/opt/ruby/bin:$GOPATH/bin:$PATH

    # If this is an interactive shell, then configure the prompt (else, it's an
    # x11 session)
    # http://unix.stackexchange.com/questions/26676/how-to-check-if-a-shell-is-login-interactive-batch
    if [[ $- == *i* ]]; then
        # default: PS1='\h:\W \u\$'
        # hostname cwd $
        PS1="\[$(tput setaf 2)\]\h \[$(tput setaf 4)\]\W \[$(tput setaf 10)\]$ \[$(tput sgr0)\]"
    fi

    # Development defaults for OpenStack Keystone.
    export OS_IDENTITY_API_VERSION=3
    export OS_TOKEN=ADMIN
    export OS_URL=http://localhost:35357/v3
    ;;
FreeBSD)
    ;;
esac

export PATH="$HOME/.cargo/bin:$PATH"
