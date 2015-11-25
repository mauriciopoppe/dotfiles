# Mauricio Poppe's dotfiles

[![travis](https://travis-ci.org/maurizzzio/dotfiles.svg?branch=master)](https://travis-ci.org/maurizzzio/dotfiles)
![platform osx](https://img.shields.io/badge/platform-osx-orange.svg)

## Features

- Installation fully automated with a simple [script](https://github.com/maurizzzio/dotfiles/blob/master/bin/dotfiles)
- Install only what you need e.g. if you want to test my Neovim configuration execute `dotfiles neovim`

## Requirements

- XCode Command Line Tools, if you don't have it install it with `$ xcode-select --install`
- ZSH (installed by default on OSX)

## Installation

```sh
curl -q https://raw.githubusercontent.com/maurizzzio/dotfiles/master/install.sh -o $TMPDIR/install.sh && source $TMPDIR/install.sh
```

The script above clones the repository to `~/.dotfiles`, in addition the `bin/` directory will be added to your path for the current session

All operations are done through the `dotfiles` script

```
$ dotfiles --help
```

| Important notes about the installer |
| ---- |
| make sure you read the `install.zsh` script and the README file included on each directory before executing `$ dotfiles [folder]` |
| executing `$ dotfiles [folder]` might symlink some files of this repo to your dotfiles, this script makes a backup of your existing dotfiles with the name `[name].backup` |

For example if you want to install my configuration of tmux execute

```
$ dotfiles tmux
```

Which calls the `install.zsh` script located inside the folder `tmux/`, you
can do this with all the first level directories of this repo e.g. `$ dotfiles
[zsh|tmux|neovim|...]`

You can also install the triumvirate (zsh + tmux + neovim) with a single command

```
dotfiles essential
```

Additionally you can install brew formulas, applications, node.js/python global
packages and alfred workflows with

```
dotfiles complete
```

### Post installation

#### General

- Remap <kbd>caps lock</kbd> to <kbd>control</kbd> *preferences > keyboard > modifier keys* (if you're a neovim/vim fan)
- Install your desired powerline from from [powerline/fonts](https://github.com/powerline/fonts) (I'm currently using *Inconsolata dz, 12px, line spacing 0.8*)

```sh
curl -O https://rawgit.com/powerline/fonts/master/InconsolataDz/Inconsolata-dz%20for%20Powerline.otf && open Inconsolata-dz%20for%20Powerline.otf
```

#### Terminal

Note: only do the following if you're going to use Terminal.app

- Install your desired [Terminal color](https://github.com/mbadolato/iTerm2-Color-Schemes) (I'm currently using *Monokai dimmed*)

```sh
curl -O https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/terminal/DimmedMonokai.terminal && open DimmedMonokai.terminal
```

- Under *DimmedMonokai* profile change the font to the one downloaded above

#### iTerm

Note: only do the following if you're going to use iTerm2

- Install your desired [iTerm color](https://github.com/mbadolato/iTerm2-Color-Schemes) (I'm currently using *Monokai dimmed*)

```sh
curl -O https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/DimmedMonokai.itermcolors && open DimmedMonokai.itermcolors
```

- Set the downloaded font on iTerm *iTerm > preferences > profiles > text* (change it for both regular and non-ascii fonts)
- Uncheck *use lion-style full screen* on General
- Load preferences from the custom folder `dotfiles/iTerm2`

## What's included? And how to customize?

Refer to the file `install.zsh` that each folder has, after cloning the repo you
can add whatever you need inside each script

## Screenshot

<img width="1920" alt="screen shot 2015-11-23 at 8 02 58 pm" src="https://cloud.githubusercontent.com/assets/1616682/11353856/52f4d452-921d-11e5-8f32-7e4aa5ae3a91.png">

## Study links

- [vim primer](https://danielmiessler.com/study/vim/)
- [tmux primer](https://danielmiessler.com/study/tmux/)

## Credits

Big parts of my dotfiles were inspired (in most cases copied :P) from other
dotfiles, all the credit belongs to them

In particular I was inspired by the following dotfiles

- [Bruno Sutic](https://github.com/nicknisi/dotfiles)
- [Nicolas Gallagher](https://github.com/necolas/dotfiles)
- [Nick Nisi](https://github.com/bruno-/dotfiles)
- [Mislav Marohnić](https://github.com/mislav/dotfiles)
- [b4b4r07](https://github.com/b4b4r07/dotfiles)
- [Martin Toma](https://github.com/martin-svk/dot-files)
- [Terry Ma](https://github.com/terryma/dotfiles)

2015 @ MIT license

[antigen]: https://github.com/zsh-users/antigen
[tpm]: https://github.com/tmux-plugins/tpm
[vim-plug]: https://github.com/junegunn/vim-plug
