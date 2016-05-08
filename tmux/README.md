TMUX
====

Intro: [article](http://blog.hawkhost.com/2010/06/28/tmux-the-terminal-multiplexer/)

Cheatsheet: [tmux cheatsheet](http://hyperpolyglot.org/multiplexers)

Prefix: `<C-space>`

## Utilities

- save env `prefix + <C-s>`
- restore env `prefix + <C-r>`
- open a link `prefix + <C-u> + o`

## Session mappings

- create session: `tns <name>`
- detach session: `td`
- attach session: `ta <name>`
- navigate through sessions `prefix + <C-[>` and `prefix + <C-]>`
- quick switch session `prefix + j <name>`
- last session `prefix + space`
- rename session `prefix + $`
- kill session: `tks <enter>` (select with `<C-p>` and `<C-n>`)

## Window mappings

- create window `prefix + c`
- navigate through windows `prefix + p` and `prefix + n`
- last window `prefix + l`
- rename window `prefix + ,`
- kill window `prefix + &`

## Pane mappings

- create vertical pane `prefix + (\)` or `prefix + |`
- create horizontal pane `prefix + -`
- last pane `prefix + ;`
- rotate panes `prefix + o`
- kill window `prefix + x`

