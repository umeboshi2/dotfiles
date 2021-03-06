# -*- mode: sh -*-
# ~/.bash_aliases


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# use htop for top if available
if [ -x /usr/bin/htop ]; then
    alias top=htop
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

alias dquilt="quilt --quiltrc=${HOME}/.quiltrc-dpkg"
complete -F _quilt_completion $_quilt_complete_opt dquilt

alias grepc="grep --color=always"

#https://github.com/mgrouchy/dotfiles/blob/master/.zshalias#L31
alias pipup='pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip install -U'


