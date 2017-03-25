# -*- mode: sh -*-
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# add ~/bin to PATH
if [ -d ~/bin ]; then
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
#force_color_prompt=yes

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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
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
fi

# add ~/local/python to PYTHONPATH
if [ -d ~/local/python ]; then
    export PYTHONPATH=~/local/python:$PYTHONPATH
fi

# setup rbenv if exists
if [ -d ~/.rbenv ]; then
    export PATH=~/.rbenv/bin:$PATH
    eval "$(rbenv init -)"
fi

# setup go env if exists
if [ -d ~/local/go ]; then
    export GOPATH=~/local/go
    export PATH=$GOROOT/bin:$GOPATH/bin:$PATH
fi

if [ -d ~/.yarn ]; then
    export PATH="$HOME/.yarn/bin:$PATH"
fi

# git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
# git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
# sudo aptitude install git zsh libssl-dev zlib1g-dev libreadline-dev libyaml-dev
# apt-get install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev
# git clone git://github.com/jf/rbenv-gemset.git $HOME/.rbenv/plugins/rbenv-gemset

# setup nodejs if directory exists
if [ -d ~/node_modules ]; then
    export PATH=~/node_modules/.bin:$PATH
    export PATH=./node_modules/.bin:$PATH
fi

if [ -d ~/.evm/bin ]; then
    export PATH=~/.evm/bin:$PATH
fi
# setup gems if directory exists
#if [ -d ~/local/gems -a -z $SCHROOT_USER ]; then
if [ -d ~/local/gems ]; then
    if [ -z $SCHROOT_USER ]; then
	export GEM_HOME=~/local/gems
	export PATH=~/local/gems/bin:$PATH
    fi
fi

export EDITOR=/usr/local/bin/editor

eval `keychain --eval id_rsa id_dsa`

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


