NeoVim's configuration
======================

## Documentation `:h`

- Defaults keyboard mappings: `:h index`
- Follow doc links with <kbd>C-]</kbd>

## Keyboard mappings

- <kbd>leader</kbd> = <kbd>space</kbd>

Essential mappings that I should always use

- <kbd>C-c</kbd> exit to normal mode
- <kbd>.</kbd> repeats the last change
- <kbd>fx</kbd>, <kbd>Fx</kbd> finds `x` forward/backward in the current line, next occurrences are found with <kbd>f</kbd> and <kbd>F</kbd>
- <kbd>/</kbd>, <kbd>?</kbd> to search forward/backward
- <kbd>6;</kbd>, <kbd>_</kbd> to move to last/first character in the line
- <kbd>u</kbd>, <kbd>U</kbd> to undo/redo

### Normal mode

#### Movement

- <kbd>G</kbd>, <kbd>gg</kbd> page end/start
- <kbd>C-f</kbd>, <kbd>C-b</kbd> scrolls 1 page forward/backward
- <kbd>}</kbd>, <kbd>{</kbd> move paragraph forward/backward

### Insert mode

- <kbd>C-o</kbd> `command` executes `command` and return to Insert Mode
- <kbd>C-w</kbd> deletes a word before the cursor
- <kbd>C-u</kbd> deletes all the inserted characters in the current line
- <kbd>C-t, C-d</kbd> line indentation
- <kbd>S-←</kbd>, <kbd>S-→</kbd> moves to the previous/next word

### Visual mode `:h visual-operators`

#### Visual block mode `:h blockwise-operators`

Enter visual block mode with <kbd>C-v</kbd>

- <kbd>_</kbd> <kbd>I</kbd> Prepend text in front of all the selected lines
- <kbd>&#36;</kbd> <kbd>A</kbd> Append text in front of all the selected lines

### Command-line mode

- `:!{command}` execute `command` with a shell
- `:r !command` executes an external `command` and inserts its standard output below the cursors of the specified line
- `:le`, `:ce`, `:ri` left, center, right the line

## Day to day tasks

### Search and replace `:h usr_27` `:h find-replace`

- `:[range]s/{pattern}/{string}/[flags]` substitute `pattern` with `string`
  - `[range]` examples 
    - `(empty)` current line
    - `1,3` between the lines 1 and 3
    - `%` entire file
  - `{pattern}` examples
    - `the` exact match
    - `/<\the`, `/the\>` matches words that start/end in `the`
    - `/^the`, `/the$` matches lines that are exactly `the`
    - `/<\the\>` matches words that are exactly `the`
  - Common flags
    - `g` all occurrences in the line
    - `c` confirm with prompt
    - `e` don't issue an error message
    - `i` ignore case
  - Important notes
    - if the pattern/string contain the char `/` we can use another character to separate the words e.g. `:[range]s%{pattern}%{string}%[flags]` 

Selectively search and replace in a single file

- Search a pattern with `/` or `/\<WORD>\>`
- Replace the occurrence with `cgn{replace}` (`gn` search forward for the last used pattern)
- Find next `n` and decide to apply the same operation with `.`

Search and replace in multiple files

- Load all files as vim arguments with `:args **`
- Execute the substitution with `:argdo`

```VimL
:argdo %s/hello/world/gec | update
```

### Spelling

- <kbd>]s</kbd> , <kbd>[s</kbd> cycle through misspelled words
- <kbd>z=</kbd> on a misspelled word to get suggestion
- <kbd>zg</kbd> to mark a misspelled as a good word
- <kbd>zw</kbd> to mark a misspelled as a wrong word

### Folds `:h folds`

A fold has the form

```sh
" {{{

" }}}
```

- Create a fold <kbd>zf</kbd> (works with seletions too)
- Toggle fold open/close <kbd>za</kbd>
- Expand all folds <kbd>zR</kbd>
- Collapse all folds <kbd>zM</kbd>

## Manuals

- `:h quickref` - list of all the default keys, it's HUGE
- `:h usr_toc` - user manual table of contents
- [Vim cheatsheet](https://cdn.shopify.com/s/files/1/0165/4168/files/preview.png)
- [VimScript cheatsheet](http://ricostacruz.com/cheatsheets/vimscript.html)

## Plugins

Refer to `plugins-keys.vim`

- Git wrapper (tpope/vim-fugitive), `:Git, :Gstatus, :Gread, :GWrite`
  - `:Gstatus` cheatsheet http://vimcasts.org/episodes/fugitive-vim-working-with-the-git-index/
- Visual selection (terryma/vim-expand-region)
  - <kbd>v</kbd> expands the selection
  - <kbd>C-v</kbd> shrinks the selection
- Jumping in the viewport (easymotion/vim-easymotion)
  - <kbd>Leader</kbd> <kbd>f</kbd> 2-character search motion
- Comments (tpope/vim-commentary)
  - <kbd>gcc</kbd> comments a line
  - <kbd>4gcc</kbd> comments the following 4 lines (including the current line)
  - <kbd>gcap</kbd> comments a paragraph
- Multiple cursors (terryma/vim-multiple-cursors)
  - <kbd>C-n</kbd> to highlight the current word, pressing it again finds the next occurrence and places another virtual cursor
  - <kbd>C-p</kbd> remove the current virtual cursor and go back to the previous virtual cursor location
- Sessions
  - Created with `:Obsess`
  - Sessions are saved inside the cwd as `Session.vim`, init nvim as `nvim -S`

