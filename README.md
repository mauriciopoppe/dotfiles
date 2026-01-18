# Mauricio Poppe's dotfiles

![platform macos](https://img.shields.io/badge/platform-macOS-orange.svg)
![platform linux](https://img.shields.io/badge/platform-linux-blue.svg)

## Core Stack

- **Ghostty**: GPU-accelerated terminal emulator
- **Zsh**: With Powerlevel10k and custom modules
- **Tmux**: For session management
- **Neovim**: IDE-like setup powered by Lazy.nvim

## Features

- **Automated & Modular**: Installation is fully automated via the [dotfiles script](https://github.com/mauriciopoppe/dotfiles/blob/master/zsh/bin/dotfiles). You can install the entire suite or just specific modules (e.g., `dotfiles neovim`, `dotfiles ghostty`).
- **Active Configuration**: Unlike passive symlink managers like **GNU Stow**, this setup actively provisions your environment. It handles package installation (Homebrew, Apt, NPM), compiles dependencies, and sets system defaults within the same workflow.
- **Smart Adaptability**: While tools like **Chezmoi** offer great templating, this setup provides full imperative control. It intelligently detects your environment—whether it's macOS or Linux and dynamically adjusts the cmd prompt, default editors, and paths to match.

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
[zsh|tmux|neovim|ghostty|...]`

### Post installation

- **Ghostty**: Run `dotfiles ghostty` to link the configuration.
- Install Alfred 4/5, remap <kbd>cmd+spacebar</kbd> following https://www.alfredapp.com/help/troubleshooting/cmd-space/.
- Remap <kbd>caps lock</kbd> to <kbd>control</kbd> *preferences > search for: "keyboard shortcuts"*
- Hide dock *preferences > search for: "dock"*
- Zoom with ctrl + scroll *preferences > search for: "Use scroll gesture with modifier keys to zoom"*
- Update fonts in/out of tmux: `bash -x zsh/term/fix-terminfo.sh`
- Install a patched font from [nerd fonts](https://www.nerdfonts.com/) (I'm currently using *Inconsolata go*)

## What's included? And how to customize it?

Refer to the file `install.zsh` that each folder has, after cloning the repo you
can add whatever you need inside each installation script

## How do I use these tools?

I talk about my workflow in this article: https://www.mauriciopoppe.com/notes/misc/productivity-skills

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
