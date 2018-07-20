# dotfiles

Uses fresh:

https://github.com/freshshell/fresh

Install:

```sh
FRESH_LOCAL_SOURCE=umeboshi2/dotfiles bash -c "`curl -sL get.freshshell.com`"
```

## make environment


new xterm (should run .bashrc)

Generate-main-venv (should just install ~/.dotfiles/requirements.txt)

setup-nodeenv (will setup nodejs environment)


## debian packages

keychain - used for ssh gpg agents; find or start agents on each interactive shell (also use ssh-askpass-gnome)

iputils-ping - ping command



##libdevel packages


These are for python packages.  Wheels are probably being used
anyway, but these packages help with: lxml, Pillow, and psycopg2

for python install python3-dev first (python-dev if you need 2.7)

libpq-dev
libpng-dev (older libpng12-dev)
libfreetype6-dev
libxml2-dev
libxslt1-dev
libssl-dev
libjpeg-dev
liblcms2-dev

### sdl 1.2

libsdl1.2-dev
libsdl-image1.2-dev
libsdl-sound1.2-dev

### sdl 2.x

libsdl2-dev 
libsdl2-gfx-dev
libsdl2-image-dev
libsdl2-mixer-dev
libsdl2-net-dev 
libsdl2-ttf-dev 

### others

many libdevels can be installed with ```apt-get build-dep pkgname```








# TODO


# workspace

Workspace is in ~/workspace

~/workspace/Cookie has cookiecutter and project templates

forked cookiecutter should use "use-yaml" branch


# python packages

hattie, hornstone, trumpet

fix travis and tox config
make sure pyup and rtd works on both

# python versioning

bump2version patch
git push && git push --tags

# node versioning

npm version patch
git push && git push --tags
npm publish





# /usr/local/bin

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
