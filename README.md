# Mauricio Poppe's dotfiles

[![travis](https://travis-ci.org/maurizzzio/dotfiles.svg?branch=master)](https://travis-ci.org/maurizzzio/dotfiles)
![platform osx](https://img.shields.io/badge/platform-osx-orange.svg)

## Features

- Installation fully automated with a simple [script](https://github.com/maurizzzio/dotfiles/blob/master/bin/dotfiles)
- Install only what you need e.g. if you want to test my NeoVim configuration just execute `dotfiles neovim`

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

![triumvirate](https://cloud.githubusercontent.com/assets/1616682/10854906/0ade5a00-7f15-11e5-8614-d00e2d452082.gif)

## Study links

- [vim primer](https://danielmiessler.com/study/vim/)
- [tmux primer](https://danielmiessler.com/study/tmux/)

## Credits

Big parts of my dotfiles were inspired (in most cases copied :P) from other
dotfiles, all the credit belongs to them

In particular I was inspired by the following dotfiles

- [Bruno Sutic](https://github.com/nicknisi/dotfiles)
- [Nick Nisi](https://github.com/bruno-/dotfiles)
- [Mislav Marohnić](https://github.com/mislav/dotfiles)
- [b4b4r07](https://github.com/b4b4r07/dotfiles)
- [Martin Toma](https://github.com/martin-svk/dot-files)
- [Terry Ma](https://github.com/terryma/dotfiles)

2015 @ MIT license

### Cheatsheet

#### tmux

Prefix: `<C-space>`

- new session: `tns name`
- detach session: `td`
- attach session: `ta`
- list sessions: `tls`
- navigate through sessions `prefix + <C-[>` and `prefix + <C-]>`

Plugins
- sidebar (opens a tree dir listing for the current path) `prefix + tab`
- save env `prefix + <C-s>`
- restore env `prefix + <C-r>`

[tmux cheatsheet](https://gist.github.com/MohamedAlaa/2961058)

#### Vim

Movement
- Through the change list (list of changes that can be undone)
  - previous change `g;`
  - next change `g,`
  - list of all change `:changes`
- Through the jump list (places where the cursor jumped rather than scrolled
  i.e. without using hjkl)
  - previous jump `<c-o>`
  - next jump `<c-i>`
  - list of all jumps `:jumps`
- Scroll Forward/Backward `<c-f>`, `<c-b>`
- Moving between paragraphs `<shift-{`, `<shift-}>`
- In a splat line `g-hjkl`

Useful remaps
- Copy/paste to system clipboard `<Space>y`, `<Space>p`
- `<Escape>` is remapped in insert mode to `jk` or `kj`

Spell checking
- Cycle through misspelled words: `]s`, `[s`
- On a misspelled word get suggestions: `z=`

Plugins
- Git wrapper (tpope/vim-fugitive), `:Git, :Gstatus, :Gread, :GWrite`
  - `:Gstatus` cheatsheet http://vimcasts.org/episodes/fugitive-vim-working-with-the-git-index/
- Visual selection (terryma/vim-expand-region)
  - `v` expands the selection
  - `<c-v>` shrinks the selection
- Fast movement with (easymotion/vim-easymotion) `<Space><Space>` plus some basic movement
  - `<Space><Space>w` move forward to some next word
  - `<Space><Space>b` move backward to some previous word
  - `<Space><Space>s` search a single character
  - `<Space><Space>fo` find the character `o` forward
  - `s` to perform a 2-character search motion
- Comments (tpope/vim-commentary)
  - `gcc` comments a line
  - `4gcc` comments the following 4 lines (including the current line)
  - `gcap` comments a paragraph
- Multiple cursors (terryma/vim-multiple-cursors)
  - `<c-n>` to highlight the current word, pressing it again finds the next occurrence and places another virtual cursor
  - `<c-p>` remove the current virtual cursor and go back to the previous virtual cursor location
- Sessions (xolox/vim-sessions)
  - When working on a specific project save the session by executing in command line mode `:SaveSession name`
  - Restore a session `:OpenSesssion name` or `:OpenSession` to get the list of saved sessions
  - Sessions are saved inside `~/.vim/sessions/{name}` to make `tmux-resurrect` restore the session properly initialize vim with `vim -S ~/.vim/sessions/{name}`

[antigen]: https://github.com/zsh-users/antigen
[tpm]: https://github.com/tmux-plugins/tpm
[vim-plug]: https://github.com/junegunn/vim-plug
