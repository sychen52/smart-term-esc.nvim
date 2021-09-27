# smart-term-esc.nvim

Many people really want to do "tnoremap <Esc> <C-\><C-n>". However, these is a few command line utilties they rely on also use <Esc>. This is a plugin that let you map <Esc to <C-\><C-n> except when these command line utilties are running in the termial.

It is built based on [justinmk's reply](https://github.com/neovim/neovim/issues/7648#issuecomment-917390258).

## Install
```vim
Plug 'sychen52/smart-term-esc.nvim'
```

## Configure
```lua
require('smart-term-esc').setup{
    key='<Esc>',
    except={'nvim', 'fzf'}
}
```
```lua
key
```
is what you want to map to <C-\><C-n>.

```lua
except
```
is a list of processes. Once any of them is running in the terminal, the key will not be mapped.
