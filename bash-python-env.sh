
# add ~/local/python to PYTHONPATH
if [ -d $HOME/local/python ]; then
    echo "WARNING: ~/local/python should no longer be used."
    echo "WARNING: use ~/.local instead."
    echo "Adding ~/local/python to PYTHONPATH"
    export PYTHONPATH=$HOME/local/python:$PYTHONPATH
fi

if [ -n "$(which ansible)" ]; then
    #export ANSIBLE_COW_SELECTION=random
    
    # setup ansible roles path
    if [ -d $HOME/local/roles ]; then
        export ANSIBLE_ROLES_PATH=$HOME/local/roles
    fi
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

if [ -x $HOME/.local/bin/pipenv ]; then
    echo "pipenv lock downloads too many wheels"
    echo "keep checking this issue until fixed"
    echo "https://github.com/pypa/pipenv/issues/2284"
    #export PATH=$HOME/.local/bin:$PATH
    export PIPENV_VENV_IN_PROJECT=1
fi

# create main python environment in ~/.local/
if ! [ -x $HOME/.local/bin/python3 ]; then
    echo "Creating main virtualenv in $HOME/.local"
    # use system python, in case pyenv has python3
    # set to a different version
    virtualenv -p /usr/bin/python3 $HOME/.local/
fi


# skip package installs by default for pip-upgrade
# and only modify the requirements file(s).
if [ -x $HOME/.local/bin/pip-upgrade ]; then
    export PIP_UPGRADER_SKIP_PACKAGE_INSTALLATION=1
fi


# FIXME: not sure if this is needed or if ~/.pip/pip.conf is good enough
if [[ "$(hostname -s)" == "bard" ]]; then
    export PIP_INDEX_URL=http://localhost:4040/root/pypi/+simple/
else
    export PIP_INDEX_URL=http://bard:4040/root/pypi/+simple/
fi

