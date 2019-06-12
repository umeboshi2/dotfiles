# -*- mode: sh -*-
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# add ~/.local/bin to PATH
if [ -d ~/.local/bin ]; then
    export PATH=~/.local/bin:$PATH
fi

# add ~/bin to PATH
if [ -d ~/bin ]; then
    echo "WARNING: ~/bin detected"
    export PATH=~/bin:$PATH
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return


# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# history file based on tty
export HISTFILE=~/.bash_histories`tty`
if ! [ -d `dirname ${HISTFILE}` ]; then
    echo "Creating directory for ${HISTFILE}"
    mkdir -p `dirname ${HISTFILE}`
fi


# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;33m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# add fortunes
if [ -x /usr/games/fortune ]; then
    echo "==================================================================="
    fortune
    echo "==================================================================="
else echo "FORTUNE NOT INSTALLED"
fi

# add ~/local/python to PYTHONPATH
if [ -d ~/local/python ]; then
    echo "WARNING: ~/local/python should no longer be used."
    echo "WARNING: use ~/.local instead."
    echo "Adding ~/local/python to PYTHONPATH"
    export PYTHONPATH=~/local/python:$PYTHONPATH
fi

if [ -n "$(which ansible)" ]; then
    #export ANSIBLE_COW_SELECTION=random
    
    # setup ansible roles path
    if [ -d $HOME/local/roles ]; then
        export ANSIBLE_ROLES_PATH=$HOME/local/roles
    fi
fi

# setup go env if exists
if [ -d $HOME/.local/go ]; then
    echo "SETTING UP GO ENVIRONMENT"
    export GOROOT=$HOME/.local/go
    export PATH=$GOROOT/bin:$PATH
    export GOPATH=$HOME/workspace/go
    export GOBIN=$GOROOT/bin
fi




# setup rbenv
if [ -d $HOME/.rbenv ]; then
    export PATH=$HOME/.rbenv/bin:$PATH
    eval "$(rbenv init -)"
fi

# setup pyenv
if [ -d $HOME/.pyenv ]; then
    export PYENV_ROOT=$HOME/.pyenv
    export PATH=$HOME/.pyenv/bin:$PATH
    eval "$(pyenv init -)"
    if [ -d $HOME/.pyenv/plugins/pyenv-virtualenvwrapper ]; then
	export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
    fi
fi

# use python3 virtualenvwrapper by default
# for py2 -> mkvirtualenv [-a `pwd`] -p /usr/bin/python2 vname
# https://stackoverflow.com/a/33239250/1869821
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3


# setup evm (not needed since emacs25 avail in debian).
if [ -d ~/.evm/bin ]; then
    echo "WARNING: evm has been found, but possible not needed anymore."
    export PATH=~/.evm/bin:$PATH
fi

# Setup cask
if [ -d ~/.cask/bin ]; then
    export PATH=~/.cask/bin:$PATH
fi

# setup gems if directory exists
#if [ -d ~/local/gems -a -z $SCHROOT_USER ]; then
if [ -d ~/local/gems ]; then
    if [ -z $SCHROOT_USER ]; then
	export GEM_HOME=~/local/gems
	export PATH=~/local/gems/bin:$PATH
    fi
fi


if [ -x /usr/bin/keychain ]; then
#    if [ -x /usr/bin/fake-ssh-askpass ]; then
#	export SSH_ASKPASS=/usr/bin/ssh-askpass
#    fi
    eval `keychain --eval id_rsa id_dsa`
fi

if [ -r ~/.fresh/build/shell.sh ]; then
    source ~/.fresh/build/shell.sh
fi

if [[ "$(hostname -s)" == "bard" ]]; then
    export SDL_MOUSE_RELATIVE=0
fi

# set coffeelint config
if [ -r ~/.coffeelint.json ]; then
    export COFFEELINT_CONFIG=$HOME/.coffeelint.json
fi

if [ -r /etc/redhat-release ]; then
    echo "redhat system, using most for PAGER"
    if ! [ -x /usr/local/bin/most ]; then
	echo "WARNING /usr/local/bin/most not found!"
    else
	export PAGER=/usr/local/bin/most
    fi
fi

if [ -r ~/.config/libpq-env ]; then
    echo "Setting libpq environment variables"
    source ~/.config/libpq-env
fi


# create main python environment in ~/.local/
if ! [ -x ~/.local/bin/python3 ]; then
    echo "Creating main virtualenv in ~/.local"
    virtualenv -p python3 ~/.local/
fi


if [ -x /usr/local/bin/editor ]; then
    echo "setting EDITOR=/usr/local/bin/editor"
    export EDITOR=/usr/local/bin/editor
else
    echo "WARNING /usr/local/bin/editor not found"
fi


# for xscreensaver -window-id $DESKTOPWINID
export DESKTOPWINID=$(xwininfo -name "Desktop" | grep 'Window id' | sed 's/.*\(0x[0-9a-z]*\).*/\1/g')

# debian exports
export DEBEMAIL="joseph.rawson.works@gmail.com"
export DEBFULLNAME="Joseph Rawson"

# vagrant exports
# disable checking for box updates
export VAGRANT_BOX_UPDATE_CHECK_DISABLE=1
