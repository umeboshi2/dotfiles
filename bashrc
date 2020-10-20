# -*- mode: sh -*-
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# add ~/.local/bin to PATH
if [ -d $HOME/.local/bin ]; then
    export PATH=$HOME/.local/bin:$PATH
fi

# add ~/bin to PATH
if [ -d $HOME/bin ]; then
    echo "WARNING: ~/bin detected"
    export PATH=$HOME/bin:$PATH
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return


# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# history file based on tty
export HISTFILE=$HOME/.bash_histories`tty`
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

if [ -f $HOME/.bash_aliases ]; then
    . $HOME/.bash_aliases
fi

# setup python environment
if [ -f $HOME/.bash-python-env.sh ]; then
    . $HOME/.bash-python-env.sh
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

# setup gems if directory exists
#if [ -d ~/local/gems -a -z $SCHROOT_USER ]; then
if [ -d $HOME/local/gems ]; then
    if [ -z $SCHROOT_USER ]; then
	export GEM_HOME=$HOME/local/gems
	export PATH=$HOME/local/gems/bin:$PATH
    fi
fi

# setup evm (not needed since emacs25 avail in debian).
if [ -d $HOME/.evm/bin ]; then
    echo "WARNING: evm has been found, but possible not needed anymore."
    export PATH=$HOME/.evm/bin:$PATH
fi

# Setup cask
if [ -d $HOME/.cask/bin ]; then
    export PATH=$HOME/.cask/bin:$PATH
fi



if [ -x /usr/bin/keychain ]; then
#    if [ -x /usr/bin/fake-ssh-askpass ]; then
#	export SSH_ASKPASS=/usr/bin/ssh-askpass
#    fi
    eval `keychain --eval id_rsa id_dsa`
fi

if [ -r $HOME/.fresh/build/shell.sh ]; then
    source $HOME/.fresh/build/shell.sh
fi

if [[ "$(hostname -s)" == "bard" ]]; then
    export SDL_MOUSE_RELATIVE=0
fi

# set coffeelint config
if [ -r $HOME/.coffeelint.json ]; then
    export COFFEELINT_CONFIG=$HOME/.coffeelint.json
fi

if [ -r $HOME/.config/libpq-env ]; then
    echo "Setting libpq environment variables"
    source $HOME/.config/libpq-env
fi

# setup editor
if [ -x /usr/local/bin/editor ]; then
    echo "setting EDITOR=/usr/local/bin/editor"
    export EDITOR=/usr/local/bin/editor
else
    echo "WARNING /usr/local/bin/editor not found"
fi


# for xscreensaver -window-id $DESKTOPWINID
if ! [ -z ${DISPLAY+x} ]; then
    export DESKTOPWINID=$(xwininfo -name "Desktop" | grep 'Window id' | sed 's/.*\(0x[0-9a-z]*\).*/\1/g')
fi


# debian exports
export DEBEMAIL="joseph.rawson.works@gmail.com"
export DEBFULLNAME="Joseph Rawson"

# vagrant exports
# disable checking for box updates
export VAGRANT_BOX_UPDATE_CHECK_DISABLE=1

# misc exports
export QT_QPA_PLATFORMTHEME="qt5ct"

if [ -r /etc/redhat-release ]; then
    echo "redhat system, using most for PAGER"
    if ! [ -x /usr/local/bin/most ]; then
	echo "WARNING /usr/local/bin/most not found!"
    else
	export PAGER=/usr/local/bin/most
    fi
fi

