# dotfiles

:) http://www.drbunsen.org/the-text-triumvirate/

- iTerm2
- zsh + antigen
- tmux + tpm
- vim + Vundle

## Installation

- Clone and run `install.zsh`
- Install powerline fonts
  - https://github.com/powerline/fonts
- Set up iterm2 colors and a patched font
  - https://github.com/mbadolato/iTerm2-Color-Schemes (currently I'm using Monokai dimmed)
  - https://gist.github.com/kevin-smets/8568070#install-a-patched-font
- Install tmux plugins (unfortunately it's not automated yet)
  - Open tmux, hit `<C-space>I` to fetch all the plugins

Additional notes
- First time installation
  - See https://github.com/Valloric/YouCompleteMe#mac-os-x-installation

## Screenshot

![triumvirate](https://cloud.githubusercontent.com/assets/1616682/10854906/0ade5a00-7f15-11e5-8614-d00e2d452082.gif)

## Useful links

- [vim primer](https://danielmiessler.com/study/vim/)
- [tmux primer](https://danielmiessler.com/study/tmux/)

### Cheatsheet

#### tmux

Prefix: `<C-space>`

- new session: `tns name`
- detach session: `td`
- attach session: `ta`
- list sessions: `tls`

Plugins
- sidebar (opens a tree dir listing for the current path) `prefix + tab`
- save env `prefix + <C-s>`
- restore env `prefix + <C-r>`

[tmux cheatsheet](https://gist.github.com/MohamedAlaa/2961058)

#### Vim

Movement
- Among the places where the cursor was: `<c-i>`, `<c-o>`
- Scroll Forward/Backward `<c-f>`, `<c-b>`
- Moving between paragraphs `<shift-{`, `<shift-}>`

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

