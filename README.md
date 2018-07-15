dotfiles
========

Uses fresh:

https://github.com/freshshell/fresh

Install:

```sh
FRESH_LOCAL_SOURCE=umeboshi2/dotfiles bash -c "`curl -sL get.freshshell.com`"
```

make environment
=================

new xterm (should run .bashrc)

Generate-main-venv (should just install ~/.dotfiles/requirements.txt)

setup-nodeenv (will setup nodejs environment)







TODO
====

workspace
==========

Workspace is in ~/workspace

~/workspace/Cookie has cookiecutter and project templates

forked cookiecutter should use "use-yaml" branch


python packages
================

hattie, hornstone, trumpet

fix travis and tox config
make sure pyup and rtd works on both

python versioning
------------------

bump2version patch
git push && git push --tags

node versioning
----------------

npm version patch
git push && git push --tags
npm publish





/usr/local/bin
---------------

- docker-machine

- docker-machine-driver-kvm

- minishift

- s2i

- notes for one-liners

count inotify instances per process
https://unix.stackexchange.com/a/15549
for foo in /proc/*/fd/*; do readlink -f $foo; done | grep inotify | sort | uniq -c | sort -nr



lorentz contraction

https://www.facebook.com/umeboshi3/posts/1378958012219967
