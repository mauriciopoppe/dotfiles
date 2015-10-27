# dotfiles

Powered by antigen

## Installation

Clone and run `install.zsh`

## Notes

### iTerm2 setup

- https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized
- http://rottmann.net/2013/03/launch-iterm-2-on-startup-without-opening-a-terminal-window/
- http://apple.stackexchange.com/questions/92004/is-there-a-way-to-hide-certain-apps-from-the-cmdtab-menu

### Vim

[primer](https://danielmiessler.com/study/vim/)

#### Movement

- Among the places where the cursor was: `<c-i>`, `<c-o>`
- Scroll Forward/Backward `<c-f>`, `<c-b>`
- Moving between paragraphs `<shift-{`, `<shift-}>`

#### Remaps

In normal mode

- Save a file `<Space>w`
- Copy/paste to system clipboard `<Space>y`, `<Space>p`
- `<Escape>` is remapped in insert mode to `jj`

#### Plugins

- Git wrapper (tpope/vim-fugitive), `:Git, :Gstatus, :Gread, :GWrite`
  - `:Gstatus` cheatsheet http://vimcasts.org/episodes/fugitive-vim-working-with-the-git-index/
- Opening files `<c-p>` (kien/ctrlp)
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
  - `<c-n>` to highlight the current word, pressing it again finds the next ocurrence and places another virtual cursor
  - `<c-p>` remove the current virtual cursor and go back to the previous virtual cursor location

