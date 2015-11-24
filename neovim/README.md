NeoVim's configuration
======

- [Vim cheatsheet](https://cdn.shopify.com/s/files/1/0165/4168/files/preview.png)
- [Vimscript cheatsheet](http://ricostacruz.com/cheatsheets/vimscript.html)

Movement
- Scroll Forward/Backward `<c-f>`, `<c-b>`
- Moving between paragraphs `<shift-{`, `<shift-}>`

Spell checking
- Cycle through misspelled words: `]s`, `[s`
- On a misspelled word get suggestions: `z=`
- `zg` to mark the word as a good word
- `zw` to mark the word as a wrong word

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
  - Sessions are saved inside `~/.config/nvim/sessions/{name}` to make `tmux-resurrect` restore the session properly initialize vim with `vim -S ~/.config/nvim/sessions/{name}`


