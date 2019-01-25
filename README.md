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



## libdevel packages


These are for python packages.  Wheels are probably being used
anyway, but these packages help with: lxml, Pillow, and psycopg2

for python install python3-dev first (python-dev if you need 2.7)

### Build with pyenv 

apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev


### Pillow deps
libpng-dev (older libpng12-dev)
libfreetype6-dev
libjpeg-dev
liblcms2-dev

### lxml deps
libxml2-dev
libxslt1-dev
zlib1g-dev


libssl-dev

### psycopg2 deps
libpq-dev


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

### useful libs

libncurses5-dev
libreadline-dev


### others

many libdevels can be installed with ```apt-get build-dep pkgname```




## debian auto install

- https://wiki.debian.org/DebianInstaller/Preseed

- https://www.debian.org/releases/stable/i386/apbs02.html.en

- https://wiki.debian.org/DebianInstaller/Modify/CD

- packages: xorriso (hybrid image maker), isolinux





# TODO

- try using doom-modeline


# Other notes and things to remember

## workspace

Workspace is in ~/workspace

~/workspace/Cookie has cookiecutter and project templates

forked cookiecutter should use "use-yaml" branch


## python packages

hattie, hornstone, trumpet, netinstauto

fix travis and tox config
make sure pyup and rtd works on each


## python versioning

bump2version patch
git push && git push --tags

## node versioning

npm version patch
git push && git push --tags
npm publish





## /usr/local/bin

- docker-machine

- docker-machine-driver-kvm

- minishift

- s2i

- notes for one-liners

count inotify instances per process
https://unix.stackexchange.com/a/15549
for foo in /proc/*/fd/*; do readlink -f $foo; done | grep inotify | sort | uniq -c | sort -nr

# python set interactive at code point
import code ;code.interact(local=dict(globals(), **locals()))


lorentz contraction

https://www.facebook.com/umeboshi3/posts/1378958012219967
