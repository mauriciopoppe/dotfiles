# Mauricio Poppe's dotfiles

![platform macos](https://img.shields.io/badge/platform-macOS-orange.svg)
![platform linux](https://img.shields.io/badge/platform-linux-blue.svg)

## Features

- Installation fully automated with a simple [script](https://github.com/mauriciopoppe/dotfiles/blob/master/zsh/bin/dotfiles)
- Install only what you need e.g. if you want to test my Neovim configuration execute `dotfiles neovim`

## Requirements

### MacOS

- XCode Command Line Tools, if you don't have it install it with `xcode-select --install`
- zsh (installed by default on OSX)

### Linux

- zsh

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
- Install a patched font from [nerd fonts](https://www.nerdfonts.com/) (I'm currently using *Inconsolata go*)

#### iTerm 2

- Install the profiles located at `@macos/iTerm2/Profiles.json`, *iTerm > preferences > profiles > import JSON profiles*

![Screen Shot 2021-01-12 at 9 05 27 PM](https://user-images.githubusercontent.com/1616682/104408983-24369680-551a-11eb-8208-7a45a6061d93.jpg)

- Set the downloaded font on iTerm *iTerm > preferences > profiles > text* (change it for both regular and non-ascii fonts)
- Uncheck *use lion-style full screen* on General
- Support italic fonts in and out of tmux https://github.com/nicknisi/dotfiles#terminal-capabilities

```
tic -x zsh/term/xterm-256color-italic.terminfo
```

## What's included? And how to customize it?

Refer to the file `install.zsh` that each folder has, after cloning the repo you
can add whatever you need inside each installation script

## Screenshot

I talk about my workflow in this article: https://www.mauriciopoppe.com/notes/misc/productivity-skills

[![asciicast](https://asciinema.org/a/h9bEclMKVl9SONRqMe3yoyryF.svg)](https://asciinema.org/a/h9bEclMKVl9SONRqMe3yoyryF)

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

2015-Present

[tpm]: https://github.com/tmux-plugins/tpm
[vim-plug]: https://github.com/junegunn/vim-plug
