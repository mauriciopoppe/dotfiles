# Mauricio Poppe's dotfiles

[![travis](https://travis-ci.org/maurizzzio/dotfiles.svg?branch=master)](https://travis-ci.org/maurizzzio/dotfiles)
![platform osx](https://img.shields.io/badge/platform-osx-orange.svg)

## Features

- Installation fully automated with a simple [script](https://github.com/maurizzzio/dotfiles/blob/master/bin/dotfiles)
- Install only what you need e.g. if you want to test my Neovim configuration execute `dotfiles neovim`

## Requirements

- XCode Command Line Tools, if you don't have it install it with `xcode-select --install`
- ZSH (installed by default on OSX)

## Installation

```
cd ~
git clone https://github.com/mauriciopoppe/dotfiles .dotfiles
cd .dotfiles
source install.sh
```

The script above will add `~/.dotfiles/zsh/bin/` to your `PATH` for the current session

All operations are done through the `dotfiles` script

```
dotfiles --help
```

| Important notes about the installer |
| ---- |
| make sure you read the `install.zsh` script and the README file included on each directory before executing `$ dotfiles <command>` |
| executing `$ dotfiles <command>` might symlink some files of this repo to your dotfiles, this script makes a backup of already existing files as `[name].backup` |

For example if you want to install my configuration of tmux execute

```
dotfiles tmux
```

Which calls the `install.zsh` script located inside the `tmux/` folder, you
can do this with all the first level directories of this repo e.g. `$ dotfiles
[zsh|tmux|neovim|...]`

### Post installation

- Remap <kbd>caps lock</kbd> to <kbd>control</kbd> *preferences > keyboard > modifier keys*
- Install your desired powerline from from [powerline/fonts](https://github.com/powerline/fonts) (I'm currently using *Inconsolata dz, 12px, line spacing 0.8*)

```sh
curl -O https://rawgit.com/powerline/fonts/master/InconsolataDz/Inconsolata-dz%20for%20Powerline.otf && open Inconsolata-dz%20for%20Powerline.otf
```

- NTFS support: http://www.howtogeek.com/236055/how-to-write-to-ntfs-drives-on-a-mac/

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

## Secure dotfiles

Secret files are not tracked by the repo but

## What's included? And how to customize it?

Refer to the file `install.zsh` that each folder has, after cloning the repo you
can add whatever you need inside each installation script

## Screenshot

<img width="1920" alt="screen shot 2015-11-23 at 8 02 58 pm" src="https://cloud.githubusercontent.com/assets/1616682/11353856/52f4d452-921d-11e5-8f32-7e4aa5ae3a91.png">

## Study links

- [vim primer](https://danielmiessler.com/study/vim/)
- [tmux primer](https://danielmiessler.com/study/tmux/)

## Credits

Big parts of my dotfiles were inspired (in most cases copied :P) from other dotfiles, I wanna thank the following people for their contribution to the open
source community

- [Rafael Bodill](https://github.com/rafi/vim-config)
- [b4b4r07](https://github.com/b4b4r07/dotfiles)
- [Terry Ma](https://github.com/terryma/dotfiles)
- [Bruno Sutic](https://github.com/nicknisi/dotfiles)
- [Nicolas Gallagher](https://github.com/necolas/dotfiles)
- [Nick Nisi](https://github.com/bruno-/dotfiles)
- [Mislav Marohnić](https://github.com/mislav/dotfiles)
- [Martin Toma](https://github.com/martin-svk/dot-files)

Thank you all!

2015-2017

[tpm]: https://github.com/tmux-plugins/tpm
[vim-plug]: https://github.com/junegunn/vim-plug
